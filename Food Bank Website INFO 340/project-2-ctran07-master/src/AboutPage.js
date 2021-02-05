import React, { Component } from 'react';
import Jumbotron from 'react-bootstrap/Jumbotron';
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import Image from 'react-bootstrap/Image';

export class AboutPage extends Component {
    render() {
        return (
            <>
                <Jumbotron>
                    <Container>
                        <p className='lead'>OUR MISSION</p>
                        <h1 className='display-5'>Where there's a need, there's a way</h1>
                    </Container >
                </Jumbotron>

                <Container>
                    <Row>
                        <Col md={4} className='d-flex'>
                            <div>
                                <h1>Pot &#8226; luck</h1>
                                <p>
                                    <em>(noun)</em>
                                </p>
                                <p>
                                    a communal meal to which people bring food to share — whatever is offered or available in given circumstances or at a given time.
                                </p>
                            </div>
                        </Col>
                        <Col md={8} className='d=flex'>
                            <h1>About Us</h1>
                            <p>
                            </p>
                            <p>
                                The COVID-19 outbreak  has generated a sudden, unprecedented need for both support and donations
                                at food banks across the country. Although this crisis has a unique universal impact, disproportionate
                                repercussions still plague the most vulnerable populations. Food banks are calling on
                                individuals in more secure positions to donate food and lower-risk demographics to consider
                                volunteering via news outlets and social media.
                            </p>
                            <p>
                                Because food banks' supply and need varies daily, sometimes it's unclear how and where to help.
                                We believe donating shouldn't be hard. Potluck aims to connect willing donators and volunteers with
                                foodbanks near them that have the most need, as  well as indicate what is needed. Join us in
                                closing the food deficit gap!
                            </p>
                        </Col>
                    </Row>
                    <Col md={{ span: 8, offset: 4 }} className='d=flex'>
                        <Row>
                            <h1>Meet the Team</h1>
                        </Row>
                        <Row>
                            <Col className="justify-content-md-center"> <Image id='about-image' src="img/Erika.jpg" roundedCircle /> 
                            <h3>Erika Sundstrom</h3>
                            </Col>
                            <Col className="justify-content-md-center"><Image id='about-image' src="img/Collin.jpeg" roundedCircle />
                            <h3>Collin Tran</h3> </Col>
                            <Col className="justify-content-center"> <Image id='about-image' src="img/Olivia.jpeg" roundedCircle /> 
                            <h3>Olivia Oplinger</h3></Col>
                        </Row>

                
                    
                    </Col>
                </Container>
            </>
        );
    }
}

export default AboutPage;