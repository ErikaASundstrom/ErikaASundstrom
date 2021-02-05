import React, { Component } from 'react';
import PantryLI from './PantryListItem.js';
import ListGroup from 'react-bootstrap/ListGroup';
import Col from 'react-bootstrap/Col';
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Jumbotron from 'react-bootstrap/Jumbotron';



export class Pantry extends Component {
    constructor(props) {
        super(props);
        this.state = {
        }
    }

    render() {
        let count = 0;
        let favItems = this.props.needs.map((item) => {
            let component = <PantryLI key={item[count]} checkCallback={this.props.checkCallback} info={item} count={count} list="needs" />;
            count++;
            return component;
        });
        count = 0;
        let panItems = this.props.pantryItems.map((item) => {
            let component = <PantryLI key={item[count]} checkCallback={this.props.checkCallback} info={item} count={count} list="pantry" />;
            count++;
            return component;
        });

            return (
                <>
                    <Jumbotron>
                        <Container>
                            <p className='lead'>PANTRY</p>
                            <h1 className='display-5'>Create a donation list based on your favorite foodbanks' needs.</h1>
                        </Container >
                    </Jumbotron>

                    <Container>
                        <Row>
                            <h1 id="no-padding">Donation List</h1>
                        </Row>
                        <Row>
                            <p>Stay organized while you prep your trip to the foodbank!</p>
                        </Row>
                        <Row>
                            <Col>
                                <h3>Foodbank Needs</h3>
                                <ListGroup variant="flush">
                                    {favItems}
                                </ListGroup>
                            </Col>
                            <Col>
                            <h3>Pantry</h3>
                            {panItems.length === 0 ? <p>Add items from the needs list that you have in your pantry to donate.</p> :
                                <ListGroup variant="flush">
                                    {panItems}
                            </ListGroup>}
                            </Col>
                        </Row>
                    </Container>
                </>
            );
        
    }
}

export default Pantry;