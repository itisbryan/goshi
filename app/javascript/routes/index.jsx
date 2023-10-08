import React from "react";
import {BrowserRouter as Router, Routes, Route, Navigate, Outlet} from "react-router-dom";
import Home from "../components/Home";
import SignIn from "../components/SignIn";


const AuthenticatedRoute = ({ redirectPath = '/login'}) => {
    if (!localStorage.getItem('token')) {
        return <Navigate to={redirectPath} replace/>
    }

    return <Outlet/>
}

const UnauthenticatedRoute = ({ redirectPath = '/'}) => {
    if (!!localStorage.getItem("token")) {
        return <Navigate to={redirectPath} replace />;
    }

    return <Outlet />;
}

export default (
    <Router>
        <Routes>
            <Route element={<UnauthenticatedRoute />}>
                <Route path='/login' element={<SignIn />}/>
            </Route>
            <Route element={<AuthenticatedRoute/>}>
                <Route path='/' element={<Home />}/>
            </Route>
        </Routes>
    </Router>
);
