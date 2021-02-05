import React, { Component } from 'react'; //import React Component
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import Jumbotron from 'react-bootstrap/Jumbotron';
import {Search} from './Search';

export class MyJumbotron extends Component {
    render() {
        return (
            <Jumbotron>
                <Container>
                    <h1>Connecting what you can offer with those who need it.</h1>
                    <Row className="p-5">
                        <Col>
                            <Search searchCallback={this.props.searchCallback}/>
                        </Col>
                    </Row>
                </Container >
            </Jumbotron>
        );
    }
}

export default MyJumbotron;