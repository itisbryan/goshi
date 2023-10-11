import React, { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";
import useConsumer from "../channels/consumer";
import {Toastify} from "../helpers/Toastify";

const consumer = useConsumer();

export default ({ channel }) => {
    const [message, setMessage] = useState('');

    console.log(consumer.subscriptions.create('NotificationChannel'))

    useEffect(() => {
        consumer.subscriptions.create(
            { channel },
            {
                connected() {
                    console.log('connected')
                },
                received({ message }) {
                    console.log(message)
                    setMessage(message)
                }
            }
        )

        return () => {
            consumer.disconnect()
        }
    });

    useEffect(() => {
        if (message.length){
            Toastify.fire({icon: 'info', title: message});
        }
        setMessage('')
    }, [message])
};