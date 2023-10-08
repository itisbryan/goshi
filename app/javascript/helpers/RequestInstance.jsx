import axios from "axios";

export const authenticatedRequestInstance = axios.create({
    headers: {
        Authorization: `Bearer ${localStorage.getItem('token')}`,
        "Accept": "application/json",
        "Content-Type": "application/json",
    }
})

export const anonymousRequestInstance = axios.create({
    headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
    }
})