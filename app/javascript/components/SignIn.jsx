import React, {useState} from "react";
import axios from "axios";
import {Button} from "react-daisyui";
import {useNavigate} from "react-router-dom";
import {Toastify} from "../helpers/Toastify";
import {anonymousRequestInstance} from "../helpers/RequestInstance";

const SignIn = () => {
    const navigate = useNavigate();
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [errorMessage, setErrorMessage] = useState('');

    const removeForm = () => {
        setEmail('');
        setPassword('');
    }

    const handleLogin = async(e) => {
        e.preventDefault();

        if (email.length < 1 || password.length < 1) {
            setErrorMessage('form could not be blank');
            return;
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

    return (
        <div className="h-screen w-full flex justify-center items-center">
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
                    <Button className="mt-8 btn-primary" type="submit">Login</Button>
                </div>
            </form>
        </div>

    );
}

export default SignIn;