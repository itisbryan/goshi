import {anonymousRequestInstance, authenticatedRequestInstance} from "../helpers/RequestInstance";
import {Toastify} from "../helpers/Toastify";
import VideoFrame from "./VideoFrame";
import React, {useEffect, useState} from "react";

const VideoList = () => {
    const [videos, setVideos] = useState([]);

    useEffect(async () => {
       fetchVideos().then((r) => setVideos(r));
    }, []);

    const fetchVideos = async () => {
        try {
            const response = await authenticatedRequestInstance(localStorage.getItem('token')).get('/api/v1/post_videos');
            return response.data['details']['videos'];
        } catch (err) {
            await Toastify.fire({icon: 'error', title: err.response.data['message']});
        }
    }

    const allVideos = videos.map((video, index) => {
       return(
           <div className="w-screen" key={index}>
               <VideoFrame video={video}/>
           </div>
       )
    });

    const noAvailableVideo = (
        <>
            <div className="hero min-h-screen bg-base-200">
                <div className="hero-content text-center">
                    <div className="max-w-md">
                        <h1 className="text-5xl font-bold mb-10">No available videos</h1>
                        <button className="btn btn-primary">Add your new video</button>
                    </div>
                </div>
            </div>
        </>
    )

    return(
        <div className="w-screen grid content-center align-items-center justify-content-center">
           { videos.length > 0 ? allVideos : noAvailableVideo }
        </div>
    )
}

export default VideoList;