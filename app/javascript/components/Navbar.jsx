import React, {useEffect, useMemo, useState} from "react";
import {authenticatedRequestInstance} from "../helpers/RequestInstance";
import {Toastify} from "../helpers/Toastify";
import axios from "axios";
import {Link, useNavigate} from "react-router-dom";
import {Button} from "react-daisyui";
import NewVideoModal from "./NewVideoModal";

export default class Navbar extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            userInfo: {},
            isOpenModal: false,
        }
    };

    async componentDidMount() {
        try {
            const response = await authenticatedRequestInstance(localStorage.getItem('token')).get('/api/v1/global_state');
            this.setState({ userInfo: response.data['details'] });
        } catch (err) {
            await Toastify.fire({icon: 'error', title: err.response.data['message']});
        }
    }

   openModal = () => {
        this.setState({ isOpenModal: true })
   };

    closeModal = () => {
        this.setState({ isOpenModal: false })
    }


    renderButtonLogin = (
        <button>Login</button>
    )

    render() {
        return(
            <div className="navbar bg-base-100 border">
                <div className="navbar-start">
                    <div className="dropdown">
                        <label tabIndex={0} className="btn btn-ghost btn-circle">
                            <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" fill="none" viewBox="0 0 24 24"
                                 stroke="currentColor">
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M4 6h16M4 12h16M4 18h7"/>
                            </svg>
                        </label>
                        <ul tabIndex={0}
                            className="menu menu-sm dropdown-content mt-3 z-[1] p-2 shadow bg-base-100 rounded-box w-52">
                            <li><a>Homepage</a></li>
                            <li><a>Portfolio</a></li>
                            <li><a>About</a></li>
                        </ul>
                    </div>
                </div>
                <div className="navbar-center">
                    <a className="btn btn-ghost normal-case text-5xl">GOSHI</a>
                </div>
                <div className="navbar-end">
                    <button className="btn btn-ghost btn-circle">
                        <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" fill="none" viewBox="0 0 24 24"
                             stroke="currentColor">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2"
                                  d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                        </svg>
                    </button>
                    <button className="btn btn-ghost btn-circle mx-4 dropdown dropdown-end">
                        <div className="avatar placeholder" tabIndex={0}>
                            <div className="bg-neutral-focus text-neutral-content rounded-full w-8">
                                <span>{this.state.userInfo?.username?.split('')[0]}</span>
                            </div>
                        </div>
                        <ul tabIndex={0}
                            className="mt-3 z-[1] p-2 shadow menu menu-sm dropdown-content bg-base-100 rounded-box w-52">
                            <li>
                                <button className="justify-between" onClick={(e) => document.getElementById('new-video-modal').showModal()}>
                                    Share new video
                                </button>
                            </li>
                            <li><a>Settings</a></li>
                            <li><button onClick={(e) => {localStorage.setItem('token', null)}}>Logout</button></li>
                        </ul>
                    </button>
                </div>
                {  <NewVideoModal isSetOpen={this.state.isOpenModal} onClose={this.closeModal}/> }
            </div>

        )
    };
}