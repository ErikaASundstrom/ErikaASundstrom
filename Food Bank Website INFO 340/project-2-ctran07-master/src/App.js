import React, { Component } from 'react';
import Container from 'react-bootstrap/Container';
import MyJumbotron from './Jumbotron.js';
import MyHeader from './Header.js';
import FavoritesCardDeck from './FavoritesCardDeck.js';
import MySpinner from './Spinner.js';
import SortBar from './SortBar.js';
import CardDeck from './CardDeck.js';
import Pantry from './Pantry.js';
import EmptyPantry from './EmptyPantry.js';
import MyFooter from './Footer.js';
import MyError from "./Error.js";
import { Route, Switch } from 'react-router-dom';
import AboutPage from "./AboutPage.js";
import _ from 'lodash';
import "./style.css";
import firebase from 'firebase/app';


class App extends Component {
    constructor(props) {
        super(props)
        this.state = {
            info: this.props.foodbanks,
            filteredInfo: this.props.foodbanks,
            inputtedText: '',
            distance: 'Any distance',
            sortOrder: 'Most urgent',
            favorited: [],
            pantryItems: [],
            currFavNeeds: [],
            error: false,
            errorType: '',
            loading: '',
            user : null
        }
    }

    componentDidMount() {
        this.setState({
            ...this.state,
            loading: true
        })
        firebase.auth().onAuthStateChanged((firebaseUser) => {
            if(firebaseUser) {
                console.log("Logged in as", firebaseUser.email);
                this.setState({user: firebaseUser})
                console.log(firebaseUser);
            } else {
                console.log("Logged out");
                this.setState({user: null})
            }
        });
        this.emailCallback(this.state.user);
        this.fetchItems();
    }

    fetchItems = () => {
        fetch('./foodbanks.json')
            .then((response) => {
                return response.json();
            }).then((data) => {
                this.setState({
                    loading: false,
                    info: data
                });
            }).catch((err) => {
                this.setState({ error: true });
                this.setState({ errorType: "data" })
                console.log("An error occurred: " + err);
            })
    }

    //Handles favoriting cards 
    favoriteCards = (name) => {
        this.setState((currState) => {
            let infoCopy = Object.assign([], currState.filteredInfo);
            let favoritedCopy = Object.assign([], currState.favorited);
            favoritedCopy.push(_.find(infoCopy, ['name', name]));
            _.find(favoritedCopy, ['name', name]).fav = true;
            for (let i = 0; i < infoCopy.length; i++) {
                if (this.state.filteredInfo[i] === _.find(infoCopy, ['name', name])) {
                    infoCopy.splice(i, 1);
                }
            }

            let needsCopy = Object.assign([], currState.currFavNeeds);
            let needs = [];
            let needsStrings = [];
            let count = 0;
            favoritedCopy.forEach((item) => {
                let needsArray = item.needs.split(',');
                needsArray.pop();
                needsArray.forEach((item2) => {
                    let currItem = item2.trim().toLowerCase();
                    currItem = currItem.replace(currItem.charAt(0), currItem.charAt(0).toUpperCase());
                    if (!needsStrings.includes(currItem)) {
                        let obj = {};
                        let key = count;
                        obj[key] = currItem;
                        needs.push(obj);
                        needsStrings.push(currItem);
                        count++;
                    }
                });
            });
            let count2 = 0;
            needsCopy.forEach((item) => {
                let count3 = 0;
                needs.forEach((item2) => {
                    if (item[count2] === item2[count3]) {
                        if (item.checked === undefined) {
                            item2.checked = false;
                        } else {
                        item2.checked = item.checked;
                        }
                    }
                    count3++;
                });
                count2++;
            });

            let pantryCopy = Object.assign([], currState.pantryItems);
            let currPantry = [];
            count = 0;
            pantryCopy.forEach((item) => {
                currPantry.push(item[count]);
                count++;
            });

            let pantry = [];
            let count4 = 0;
            favoritedCopy.forEach((item) => {
                let pantryArray = item.needs.split(',');
                pantryArray.pop();
                pantryArray.forEach((item2) => {
                    let currItem = item2.trim().toLowerCase();
                    currItem = currItem.replace(currItem.charAt(0), currItem.charAt(0).toUpperCase());
                    if (currPantry.includes(currItem)) {
                        let obj = {};
                        let key = count4;
                        obj[key] = currItem;
                        pantry.push(obj);
                        count4++;
                    }
                });
            });
            count = 0;
            pantry.forEach((item) => {
                count2 = 0;
                pantryCopy.forEach((item2) => {
                    if (item[count] === item2[count2]) {
                        item.checked = item2.checked;
                    }
                    count2++;
                });
                count++;
            });

            let favRef = firebase.database().ref(this.state.user + '/favs');
            favRef.set(favoritedCopy);
            favRef.on('value', (snapshot) => {
                let ids;
                let value = snapshot.val();
                let favs = [];
                let tempFavs = [];
                if (value){
                let favIds = Object.keys(value);
                favIds.map((favId) => {
                    let favRef2 = firebase.database().ref(this.state.user + '/favs/' + favId);
                    favRef2.on('value', (snapshot2) => {
                        let value2 = snapshot2.val();
                        if (value2){
                        let favIds2 = Object.keys(value2);
                        ids = favIds2;
                        tempFavs = favIds2.map((favId2) => {
                            return {[favId2]: value2[favId2]}
                        });
                    }
                });
                let count = 0;
                let temp = {};
                tempFavs.forEach((item) => {
                    temp[ids[count]] = item[ids[count]];
                    count++;
                });
                favs.push(temp);
                console.log(favs);
                this.setState({favorited: favs})
            });
        }
        });

            console.log(needs);
            let needsRef = firebase.database().ref(this.state.user + '/needs');
            needsRef.set(needs);

            return { filteredInfo: infoCopy, currFavNeeds: needs }
        })
    }

    //handles unfavoriting cards 
    unfavoriteCards = (name) => {
        this.setState((currState) => {
            let infoCopy = Object.assign([], currState.filteredInfo);
            let favoritedCopy = Object.assign([], currState.favorited);
            let card = _.find(favoritedCopy, ['name', name]);
            if (card.zipcode + "" === this.state.inputtedText || this.state.inputtedText === "") {
                if (card.distance === this.state.distance || this.state.distance === "Any distance") {
                    infoCopy.push(_.find(favoritedCopy, ['name', name]));
                }
            }
            _.find(favoritedCopy, ['name', name]).fav = false;
            for (let i = 0; i < favoritedCopy.length; i++) {
                if (this.state.favorited[i] === _.find(favoritedCopy, ['name', name])) {
                    favoritedCopy.splice(i, 1);
                }
            }

            let needsCopy = Object.assign([], currState.currFavNeeds);
            let needs = [];
            let needsStrings = [];
            let count = 0;
            favoritedCopy.forEach((item) => {
                let needsArray = item.needs.split(',');
                needsArray.pop();
                needsArray.forEach((item2) => {
                    let currItem = item2.trim().toLowerCase();
                    currItem = currItem.replace(currItem.charAt(0), currItem.charAt(0).toUpperCase());
                    if (!needsStrings.includes(currItem)) {
                        let obj = {};
                        let key = count;
                        obj[key] = currItem;
                        needs.push(obj);
                        needsStrings.push(currItem);
                        count++;
                    }
                });
            });

            let count2 = 0;
            needsCopy.forEach((item) => {
                let count3 = 0;
                needs.forEach((item2) => {
                    if (item.checked === undefined) {
                        item2.checked = false;
                    } else {
                    item2.checked = item.checked;
                    }
                    count3++;
                });
                count2++;
            });

            let pantryCopy = Object.assign([], currState.pantryItems);
            let currPantry = [];
            count = 0;
            pantryCopy.forEach((item) => {
                currPantry.push(item[count]);
                count++;
            });

            let pantry = [];
            let count4 = 0;
            favoritedCopy.forEach((item) => {
                let pantryArray = item.needs.split(',');
                pantryArray.pop();
                pantryArray.forEach((item2) => {
                    let currItem = item2.trim().toLowerCase();
                    currItem = currItem.replace(currItem.charAt(0), currItem.charAt(0).toUpperCase());
                    if (currPantry.includes(currItem)) {
                        let obj = {};
                        let key = count4;
                        obj[key] = currItem;
                        pantry.push(obj);
                        count4++;
                    }
                });
            });
            count = 0;
            pantry.forEach((item) => {
                count2 = 0;
                pantryCopy.forEach((item2) => {
                    if (item[count] === item2[count2]) {
                        item.checked = item2.checked;
                    }
                    count2++;
                });
                count++;
            });

            let favRef = firebase.database().ref(this.state.user + '/favs');
            favRef.set(favoritedCopy);
            favRef.on('value', (snapshot) => {
                let ids;
                let value = snapshot.val();
                let favs = [];
                let tempFavs = [];
                if (value){
                let favIds = Object.keys(value);
                favIds.map((favId) => {
                    let favRef2 = firebase.database().ref(this.state.user + '/favs/' + favId);
                    favRef2.on('value', (snapshot2) => {
                        let value2 = snapshot2.val();
                        if (value2){
                        let favIds2 = Object.keys(value2);
                        ids = favIds2;
                        tempFavs = favIds2.map((favId2) => {
                            return {[favId2]: value2[favId2]}
                        });
                    }
                });
                let count = 0;
                let temp = {};
                tempFavs.forEach((item) => {
                    temp[ids[count]] = item[ids[count]];
                    count++;
                });
                favs.push(temp);
                console.log(favs);
                this.setState({favorited: favs})
            });
        }
        });

            let needsRef = firebase.database().ref(this.state.user + '/needs');
            needsRef.push(needs);

            // let pantryRef = firebase.database().ref(this.state.user + '/pantryList');
            // pantryRef.push(pantry);

            return { filteredInfo: infoCopy, currFavNeeds: needs, pantryItems: pantry }
        });
    }

    //handles the check status of needs and pantry list items
    checkCallback = (name, check, list) => {
        if (list === "needs") {
            this.setState((currState) => {
                let needsCopy = Object.assign([], currState.currFavNeeds);
                let pantryCopy = Object.assign([], currState.pantryItems);
                let currNeed;
                let count = 0;
                needsCopy.forEach((item) => {
                    if (item[count] === name) {
                        currNeed = item;
                    }
                    count++;
                });
                if (check) {
                    let key = pantryCopy.length;
                    let obj = {};
                    obj[key] = name;
                    pantryCopy.push(obj);
                } else {
                    let num;
                    for (let i = 0; i < pantryCopy.length; i++) {
                        if (name === pantryCopy[i][i]) {
                            num = i;
                            pantryCopy.splice(i, 1);
                        }
                    }
                    let count2 = 0;
                    let pan = [];
                    pantryCopy.forEach((item2) => {
                        if (count2 >= num) {
                            let obj = {};
                            let key = count2;
                            obj[key] = item2[count2 + 1];
                            obj.checked = item2.checked;
                            pan.push(obj);
                            count2++;
                        } else {
                            let obj = {};
                            let key = count2;
                            obj[key] = item2[count2];
                            obj.checked = item2.checked;
                            pan.push(obj);
                            count2++;
                        }
                    });
                    pantryCopy = pan;
                }
                currNeed.checked = check;
                // let pantryRef = firebase.database().ref(this.state.user + '/pantryList');
                // pantryRef.push(pantryCopy);
                return { currFavNeeds: needsCopy, pantryItems: pantryCopy }
            });
        } else {
            this.setState((currState) => {
                let pantryCopy = Object.assign([], currState.pantryItems);
                let currItem;
                let count = 0;
                pantryCopy.forEach((item) => {
                    if (item[count] === name) {
                        currItem = item;
                    }
                    count++;
                });
                currItem.checked = check;
                // let pantryRef = firebase.database().ref(this.state.user + '/pantryList');
                // pantryRef.push(pantryCopy);
                return { pantryItems: pantryCopy }
            });
        }
       
    }

    handleError = () => {
        this.setState({ error: true });
        this.setState({ errorType: "user" })
    }

    filterCards = (searchQuery, distance) => {
        this.setState(() => {
            let shallowCopy1 = [];
            let shallowCopy2 = [];
            this.state.info.forEach((item) => {
                if (item.zipcode + "" === searchQuery) {
                    shallowCopy1.push(item);
                }
            });
            shallowCopy2 = shallowCopy1;
            if (distance !== "Any distance") {
                shallowCopy2 = [];
                let num = parseInt(distance);
                shallowCopy1.forEach((item) => {
                    if (item.distance <= num) {
                        shallowCopy2.push(item);
                    }
                });
            }
            if (shallowCopy2.length === 0) {
                this.handleError();
            }
            if (shallowCopy2.length !== 0) {
                this.setState({ error: false });
            }
            return { inputtedText: searchQuery, distance: distance, filteredInfo: shallowCopy2 }
        });
    }

    sortCards = (sortMetric) => {
        this.setState(() => {
            let sortedCards = [...this.state.filteredInfo];
            sortedCards.forEach((item) => {
                if (sortMetric === 'Closest to me') {
                    sortedCards.sort(function (cardA, cardB) {
                        return parseFloat(cardA.distance) - parseFloat(cardB.distance);
                    });
                } else {
                    sortedCards.sort(function (cardA, cardB) {
                        return parseFloat(cardA.urgency_num) - parseFloat(cardB.urgency_num);
                    });
                }
            })
            return { filteredInfo: sortedCards }
        })
    }

    emailCallback = (email) => {
        this.setState(() => {
            let userEmail = email;
            if (email !== null) {
                userEmail = email.replace(/[^a-zA-Z0-9]/g, "");
            }
            let favRef = firebase.database().ref(userEmail + '/favs');
            favRef.on('value', (snapshot) => {
                let ids;
                let value = snapshot.val();
                let favs = [];
                let tempFavs = [];
                if (value){
                let favIds = Object.keys(value);
                favIds.map((favId) => {
                    let favRef2 = firebase.database().ref(userEmail + '/favs/' + favId);
                    favRef2.on('value', (snapshot2) => {
                        let value2 = snapshot2.val();
                        if (value2){
                        let favIds2 = Object.keys(value2);
                        ids = favIds2;
                        tempFavs = favIds2.map((favId2) => {
                            return {[favId2]: value2[favId2]}
                        });
                    }
                });
                let count = 0;
                let temp = {};
                tempFavs.forEach((item) => {
                    temp[ids[count]] = item[ids[count]];
                    count++;
                });
                favs.push(temp);
                console.log(favs);
                this.setState({favorited: favs})
            });
        }
        });
            return {user: userEmail};
        });
    }

    render() {
        let renderCardDeck = (props) => (
            <>
                <MyJumbotron searchCallback={this.filterCards} />
                <Container>
                    <FavoritesCardDeck  {...props} info={this.state.favorited} favCallback={this.favoriteCards} unfavCallback={this.unfavoriteCards} />
                    <SortBar {...props} sortCallback={this.sortCards} />
                    {this.state.loading ? <MySpinner /> : (this.state.error
                        ? <MyError {...props} errorType={this.state.errorType} input={this.state.inputtedText} />
                        : <CardDeck {...props} info={this.state.filteredInfo} favCallback={this.favoriteCards} unfavCallback={this.unfavoriteCards} />)}
                </Container>
            </>);

        let renderPantry = (props) => (
            <>
                {this.state.favorited.length === 0 ? <EmptyPantry /> :
                    <Pantry {...props} needs={this.state.currFavNeeds} pantryItems={this.state.pantryItems} checkCallback={this.checkCallback} />}
                <Container>
                    <FavoritesCardDeck  {...props} id="pantry-fav" info={this.state.favorited} favCallback={this.favoriteCards} unfavCallback={this.unfavoriteCards} />
                </Container>
            </>
        );

        return (
            <>
                <header>
                    <MyHeader user={this.state.user} emailCallback={this.emailCallback}/>
                </header>

                <main>
                    <Switch>
                        <Route exact path='/' render={renderCardDeck} />
                        <Route exact path='/about' component={AboutPage} />
                        <Route path='/pantry' render={renderPantry} />
                    </Switch>
                </main>

                <footer>
                    <MyFooter />
                </footer>
            </>
        )
    }
}

export default App;


