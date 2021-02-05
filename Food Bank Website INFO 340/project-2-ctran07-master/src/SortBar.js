import React, { Component } from 'react';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import Form from 'react-bootstrap/Form';
import FormGroup from 'react-bootstrap/FormGroup';
import FormLabel from 'react-bootstrap/FormLabel';
import FormControl from 'react-bootstrap/FormControl';

export class SortBar extends Component {
    constructor(props) {
        super(props)
        this.state = {
            sortBy: 'Most urgent'
        }
    }

    handleSortChange = (e) => {
        this.setState({
            sortBy: e.target.value
        }, () => {
            this.props.sortCallback(this.state.sortBy)
        });
    }

    render() {
        return (
            <Row className='pt-2 pb-3'>
                <Col xs={12} md={9}>
                    <h1>Food banks in Seattle</h1>
                </Col>
                <Col xs={12} md={3} id="filters">
                    <Form inline>
                        <FormGroup className='ml-auto'>
                            <FormLabel className='pr-2'>Sort by:</FormLabel>
                            <FormControl as='select'
                                onChange={this.handleSortChange}>
                                <option>Most urgent</option>
                                <option>Closest to me</option>
                            </FormControl>
                        </FormGroup>
                    </Form>
                </Col>
            </Row>
        )
    }
}

export default SortBar;