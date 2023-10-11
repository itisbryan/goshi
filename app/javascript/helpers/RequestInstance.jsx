import axios from "axios";

export const authenticatedRequestInstance = (access_token) => {
    return axios.create({
        headers: {
            Authorization: `${access_token}`,
            "Accept": "application/json",
            "Content-Type": "application/json",
        }
    });
}

export const anonymousRequestInstance = axios.create({
    headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
    }
})