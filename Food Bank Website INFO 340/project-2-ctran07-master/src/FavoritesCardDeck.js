import React, { Component } from 'react'; //import React Component
import MyCard from "./Card.js";
import firebase from 'firebase/app';
import 'firebase/database';

export class FavoritesCardDeck extends Component {
    render() {
        //console.log(this.props.info);
        let title;
        if (this.props.info.length !== 0) {
            title = <h1>Favorites</h1>;
        }
        let infoList;
        infoList = this.props.info.map((info) => {
            let card = <MyCard key={info.name + " fav"} info={info} favCallback={this.props.favCallback} unfavCallback={this.props.unfavCallback}/>;
            return card;
        });
        
        return (
            <div>
                {title}
                <div className="card-deck">
                    {infoList}
                </div>
            </div>
        );
    }
}

export default FavoritesCardDeck;