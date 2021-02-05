import React, { Component } from 'react'; //import React Component

export class Favorite extends Component {
    constructor(props) {
        super(props);
        this.state = {
        }
    }

    handleClick = () => {
        if (!this.props.info.fav) {
            this.props.favCallback(this.props.info.name);
        } else {
            this.props.unfavCallback(this.props.info.name);
        }
    }
    render() {
        let component;
        if (this.props.info.fav) {
            component = <i className="fas fa-heart fa-lg" onClick={this.handleClick}></i>;
        } else {
            component = <i className="far fa-heart fa-lg" onClick={this.handleClick}></i>;
        }
        return(
            <div className="top-right" alt="favorite">
                {component}
            </div>
        );
    }
}