import React, { Component } from 'react';
import PantryLI from './PantryListItem.js';
import ListGroup from 'react-bootstrap/ListGroup';
import Col from 'react-bootstrap/Col';
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Jumbotron from 'react-bootstrap/Jumbotron';
import Alert from 'react-bootstrap/Alert';



export class EmptyPantry extends Component {

    render() {

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
                    <Alert variant='warning'>
                        Add some foodbanks to your favorites to create a donation list from their current needs.</Alert>
                </Container>
            </>
        );


    }
}

export default EmptyPantry;