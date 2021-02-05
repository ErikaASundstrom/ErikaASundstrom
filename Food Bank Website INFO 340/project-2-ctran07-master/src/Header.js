import React, { Component } from 'react';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';
import { NavLink } from 'react-router-dom';
import LogInModal from './LogInModal.js';
import firebase from 'firebase/app';
import 'firebase/database';

export class MyHeader extends Component {

    constructor(props) {
        super(props);
        this.state = {
        };
    }

    render() {
        return (
            <Navbar expand='lg' fixed='top' variant='light'>
                <Navbar.Brand tabIndex='0'>
                    <NavLink exact to='/' activeClassName='activeLink'>
                        <img 
                            src='./img/potluck.svg' 
                            className='d-inline-block align-top' 
                            alt='logo' 
                        />
                        Potluck
                    </NavLink>
                </Navbar.Brand >
                <Navbar.Toggle aria-controls='basic navbar-nav' />
                <Navbar.Collapse>
                    <Nav className='ml-auto'>
                        {/*Nav.Link is for React-Bootstrap*/} 
                        <Nav.Link className='mx-2' tabIndex='0'>
                            {/*NavLink(no period) is for React Router*/}
                            <NavLink exact to="/pantry" activeClassName='activeLink'>My Pantry</NavLink>
                        </Nav.Link>
                        <Nav.Link className='mx-2' tabIndex='0'>
                            <NavLink exact to="/about" activeClassName='activeLink'>About</NavLink>
                        </Nav.Link>
                        <LogInModal user={this.props.user} emailCallback={this.props.emailCallback}/>
                    </Nav>
                </Navbar.Collapse>                
            </Navbar>
        );
    }
}

export default MyHeader;