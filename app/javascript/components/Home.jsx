import React, {useState} from "react";
import Navbar from "./Navbar";
import VideoList from "./VideoList";
import Footer from "./Footer";
import Notification from "./Notification";

export default () => {
    const [notification, setNotification] = useState('');
    const [guid, setGuid] = useState('');
    // const ws = new WebSocket('ws://localhost:3000/cable')
    //
    // ws.onopen = () => {
    //     console.log('connection established');
    //     setGuid(Math.random.toString(36).substring(2 ,15));
    //
    //     ws.send(
    //         JSON.stringify({
    //             command: "subscribe",
    //             identifier: JSON.stringify({
    //                 id: guid,
    //                 channel: "NotificationChannel"
    //             }),
    //         })
    //     )
    // };
    // ws.onmessage = (e) => {
    //     const data = JSON.parse(e.data)
    //     setNotification(data)
    //     console.log(data)
    // }

    return (<>
        <header className="sticky top-0 z-50 w-screen">
            <Navbar />
        </header>
        <VideoList/>
        { localStorage.getItem("token") ? <Notification channel={ "NotificationChannel" } /> : null }
       <Footer/>
    </>)
};
