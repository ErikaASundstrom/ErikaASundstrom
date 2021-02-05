import React, { Component } from 'react';
import Form from 'react-bootstrap/Form';
import InputGroup from 'react-bootstrap/InputGroup';
import FormControl from 'react-bootstrap/FormControl';
import Button from 'react-bootstrap/Button';

export class Search extends Component {
    constructor(props) {
        super(props)
        this.state = {
            query: '',
            distance: 'Any distance'
        }
    }

    handleInputChange = () => {
        this.setState({
            query: this.search.value,
        }, () => {
            this.props.searchCallback(this.state.query, this.state.distance);
        });
    }

    handleDistanceChange = (e) => {
        this.setState({
            distance: e.target.value
        });
    }

    render() {
        return (
            <Form>
                <InputGroup className='w-75 ml-auto mr-auto'>
                    <FormControl
                        placeholder='Enter your zipcode'
                        aria-label='Zipcode input'
                        ref={input => this.search = input}
                    />
                    <FormControl as='select' custom
                        onChange={this.handleDistanceChange}>
                        <option>Any distance</option>
                        <option>1 mile radius</option>
                        <option>3 mile radius</option>
                        <option>5 mile radius</option>
                    </FormControl>
                    <InputGroup.Append>
                        <Button variant='primary' onClick={this.handleInputChange}>Find food banks</Button>
                    </InputGroup.Append>
                </InputGroup>
            </Form>
        );
    }
}

export default Search;