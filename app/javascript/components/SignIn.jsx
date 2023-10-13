import React, {useState} from "react";
import axios from "axios";
import {Button} from "react-daisyui";
import {Link, useNavigate} from "react-router-dom";
import {Toastify} from "../helpers/Toastify";
import {anonymousRequestInstance} from "../helpers/RequestInstance";

export default () => {
    const navigate = useNavigate();
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [username, setUsername] = useState('');
    const [firstName, setFirstname] = useState('');
    const [lastName, setLastname] = useState('');
    const [isLogin, setIsLogin] = useState(true);

    const removeForm = () => {
        setEmail('');
        setPassword('');
        setUsername('');
        setFirstname('');
        setLastname('');
    }

    const handleLogin = async(e) => {
        e.preventDefault();

        if (isLogin === false)
            return;

        if (email.length < 1 || password.length < 1) {
            await Toastify.fire({icon: 'error', title: 'Input could not be blank'});
        }

        const payload = {
            user: {
                email: email,
                password: password,
            }
        }

        try {
            const response = await anonymousRequestInstance.post('/api/v1/login', payload);
            localStorage.setItem('token', response.data['details']['access_token']);

            navigate('/')
        } catch(err) {
            removeForm();
            await Toastify.fire({icon: 'error', title: err.response.data['message']})
        }
    };

    const handleSignUp = async(e) => {
        e.preventDefault();

        if (isLogin === true)
            return;

        if (email.length < 1 || password.length < 1) {
            await Toastify.fire({icon: 'error', title: 'Input could not be blank'});
        }

        const payload = {
            user: {
                email: email,
                password: password,
                login: username,
                first_name: firstName,
                last_name: lastName
            }
        }

        try {
            let response = await anonymousRequestInstance.post('/api/v1/join', payload);
            await Toastify.fire({icon: 'success', title: 'Create account successfully'});
            setIsLogin(true);
        } catch(err) {
            removeForm();
            await Toastify.fire({icon: 'error', title: err.response.data['message']})
        }
    };

    const renderSignUp = () => (
        <form className="modal-box" onSubmit={handleSignUp}>
            <p className="text-2xl">Goshi</p>
            <div className="form-control max-w-xl" onSubmit={handleSignUp}>
                <label className="label mt-3">
                    <span className="label-text">Email</span>
                </label>
                <input type="text"
                       value={email}
                       onChange={(e) => setEmail(e.target.value)}
                       placeholder="Type here"
                       className="input input-bordered w-full max-w-xl" />
                <label className="label mt-3">
                    <span className="label-text">Password</span>
                </label>
                <input type="password"
                       value={password}
                       onChange={(e) => setPassword(e.target.value)}
                       placeholder="Type here"
                       className="input input-bordered w-full max-w-xl" />
                <label className="label mt-3">
                    <span className="label-text">Username</span>
                </label>
                <input type="text"
                       value={username}
                       onChange={(e) => setUsername(e.target.value)}
                       placeholder="Type here"
                       className="input input-bordered w-full max-w-xl" />
                <label className="label mt-3">
                    <span className="label-text">First name</span>
                </label>
                <input type="text"
                       value={firstName}
                       onChange={(e) => setFirstname(e.target.value)}
                       placeholder="Type here"
                       className="input input-bordered w-full max-w-xl" />
                <label className="label mt-3">
                    <span className="label-text">Last name</span>
                </label>
                <input type="text"
                       value={lastName}
                       onChange={(e) => setLastname(e.target.value)}
                       placeholder="Type here"
                       className="input input-bordered w-full max-w-xl" />
                <Button className="mt-8 " type="submit" name="login">Join</Button>
                <Button className="mt-2 btn-accent" onClick={() => setIsLogin(true)}>Login</Button>
            </div>
        </form>
    )

    const renderSignIn = () => (
        <form className="modal-box" onSubmit={handleLogin}>
            <p className="text-2xl">Goshi</p>
            <div className="form-control max-w-xl" onSubmit={handleLogin}>
                <label className="label mt-3">
                    <span className="label-text">Email</span>
                </label>
                <input type="text"
                       value={email}
                       onChange={(e) => setEmail(e.target.value)}
                       placeholder="Type here"
                       className="input input-bordered w-full max-w-xl" />
                <label className="label mt-3">
                    <span className="label-text">Password</span>
                </label>
                <input type="password"
                       value={password}
                       onChange={(e) => setPassword(e.target.value)}
                       placeholder="Type here"
                       className="input input-bordered w-full max-w-xl" />
                <Button className="mt-8 " type="submit" name="login">Login</Button>
                <Button className="mt-2 btn-accent" type="button" onClick={() => setIsLogin(false)}>Create new account</Button>
            </div>
        </form>
    )

    return (
        <div className="h-screen w-full flex justify-center items-center">
            { isLogin ? renderSignIn() : renderSignUp() }
        </div>

    );
}
