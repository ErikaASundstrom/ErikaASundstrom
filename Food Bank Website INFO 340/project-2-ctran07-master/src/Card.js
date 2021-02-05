import React, { Component } from 'react'; //import React Component
import { Favorite } from './Favorites.js';
import Card from 'react-bootstrap/Card';
import Col from 'react-bootstrap/Col';
import ProgressBar from 'react-bootstrap/ProgressBar'
import {MyModal} from './Modal';
import Button from 'react-bootstrap/Button';

export class MyCard extends Component {
    constructor(props) {
        super(props)

        this.handleShow = this.handleShow.bind(this);
        this.handleClose = this.handleClose.bind(this);

        this.state = {
            showModal: false,
        }
    }

    handleClose() {
        this.setState({ showModal: false });
    }
    
    handleShow() {
        this.setState({ showModal: true });
    }

    render() {
        let name = this.props.info.name;
        let distance = this.props.info.distance;
        let img = "img/" + this.props.info.img;
        let needs = this.props.info.needs;
        let urgencyNum = this.props.info.urgency_num;
        let progressClassName;
        if (parseInt(urgencyNum) <= 25) {
            progressClassName = 'danger';
        } else if (parseInt(urgencyNum) <= 50) {
            progressClassName = 'warning';
        } else if (parseInt(urgencyNum) <= 75) {
            progressClassName = 'success';
        } else {
            progressClassName = 'success';
        }
        
        return (
            <>
                <Col xs={12} md={6} lg={4} className="d-flex justify-content-center">
                    <Card style={{ width: '20rem' }} tabIndex="0" className="mb-4" >
                        <Card.Img variant="top" src={img} alt={name} />
                        <Favorite info={this.props.info} favCallback={this.props.favCallback} unfavCallback={this.props.unfavCallback}/>
                        <Card.Body className="d-flex flex-column">
                            <Card.Title>{name}</Card.Title>
                            <Card.Subtitle className="mb-2 text-muted">{distance} miles away</Card.Subtitle>
                            <h6 className="mb-2">Current Needs:</h6>
                            <Card.Text>{needs}</Card.Text>
                            <div className="mt-auto">
                                <Card.Subtitle className="mb-2">Current Capacity: {urgencyNum}%</Card.Subtitle>
                                <ProgressBar variant={progressClassName} now={urgencyNum} style={{ height: "20px" }} aria-valuenow={urgencyNum} aria-valuemin="0" aria-valuemax="100" />
                            </div>
                        </Card.Body>
                        <Card.Footer>
                            <Button className='pull-right' variant="link" onClick={this.handleShow}>See more</Button>
                        </Card.Footer>
                    </Card>
                </Col>
         
                <MyModal key={name} info={this.props.info} show={this.state.showModal} onHide={this.handleClose}/>
            </>
        );
    }
}

export default MyCard;
