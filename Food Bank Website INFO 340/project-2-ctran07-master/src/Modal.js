import React, { Component } from 'react'; //import React Component
import Modal from 'react-bootstrap/Modal';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import Container from 'react-bootstrap/Container';
import Image from 'react-bootstrap/Image';
import Button from 'react-bootstrap/Button';
import ProgressBar from 'react-bootstrap/ProgressBar';


export class MyModal extends Component {
    constructor(props) {
        super(props);
    }

    render() {
        let name = this.props.info.name;
        let distance = this.props.info.distance;
        let img = "img/" + this.props.info.img;
        let urgencyNum = this.props.info.urgency_num;
        let needsArray = this.props.info.needs.split(',');
        let needsList = needsArray.map((item) => {
            let component = <li key={item}>{item}</li>;
            return component;
        });
        let hoursArray = this.props.info.hours.split(',');
        let hoursList = hoursArray.map((item) => {
            let component = <li key={item}>{item}</li>;
            return component;
        });
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
            <Modal show={this.props.show}>
                <Modal.Header closeButton onClick={this.props.onHide}>
                    <Modal.Title className="modal-title" id="cardModalTitle">{name}</Modal.Title>
                </Modal.Header>

                <Modal.Body>
                    <Container>
                        <Row style={{height: '170px'}}>
                            <Image className="card-img-top" src={img} alt={name} />
                        </Row>
                        <Row>
                            <Col md={6} className="p-auto">
                                <h6 className="card-subtitle mb-2 text-muted">{this.props.info.location}</h6>
                                <address className="card-subtitle mb-2 text-muted" ahref={"tel:" + this.props.info.phone_number}>
                                    {this.props.info.phone_number}
                                </address>
                            </Col>
                            <Col md={4} className="ml-auto">
                                <h6 className="card-subtitle mb-2 text-muted">{distance + " miles away"}</h6>
                            </Col>
                        </Row>
                        <Row>
                            <Col md={6} className="p-auto">
                                <h6 className="needs-title">{"Current Needs:"}</h6>
                                <ul>
                                    {needsList}
                                </ul>
                            </Col>
                            <Col md={6} className="p-auto">
                                <h6 className="hours-title">{"Hours:"}</h6>
                                <ul>
                                    {hoursList}
                                </ul>
                            </Col>
                        </Row>
                    </Container>
                    <div className="mt-auto">
                        <h6 className="mb-2">Current Capacity: {urgencyNum}%</h6>
                        <ProgressBar variant={progressClassName} now={urgencyNum} style={{ height: "20px" }} aria-valuenow={urgencyNum} aria-valuemin="0" aria-valuemax="100" />
                    </div>
                </Modal.Body>

                <Modal.Footer>
                    <Button type="button" className="btn btn-primary"  href={this.props.info.website}>
                        {"Visit Site"}
                    </Button>
                </Modal.Footer>
            </Modal>
        );
    }
}

export default MyModal;