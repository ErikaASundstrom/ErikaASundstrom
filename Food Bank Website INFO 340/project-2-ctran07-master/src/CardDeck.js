import React, { Component } from 'react';
import MyCard from "./Card.js";


export class CardDeck extends Component {
    render() {
        let infoList = this.props.info.map((info) => {
            let card = <MyCard key={info.name} info={info} favCallback={this.props.favCallback} unfavCallback={this.props.unfavCallback}/>;
            return card;
        });

        return (
            <div className="card-deck">
                {infoList}
            </div>
        );
    }
}

export default CardDeck;