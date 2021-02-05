import React, { Component } from 'react';
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Spinner from 'react-bootstrap/Spinner';


export class MySpinner extends Component {
    render() {
        return (
            <>
                <Container>
                    <Row className='justify-content-center'>
                        <Spinner animation="border" role="status" variant="dark">
                            <span className="sr-only">Loading...</span>
                        </Spinner>
                    </Row>
                </Container>
            </>
        );
    }
}

export default MySpinner;