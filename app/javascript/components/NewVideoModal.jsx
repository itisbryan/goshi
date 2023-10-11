import React, {useEffect, useState} from "react";
import {Button} from "react-daisyui";
import {authenticatedRequestInstance} from "../helpers/RequestInstance";
import {Toastify} from "../helpers/Toastify";
import {useNavigate} from "react-router-dom";

export default ({ isSetOpen, onClose }) => {
    const navigate = useNavigate();
    const [videoTitle, setVideoTitle] = useState('');
    const [description, setDescription] = useState('');
    const [videoUrl, setVideoUrl] = useState('');
    const [errorMessage, setErrorMessage] = useState('');

    const handleSubmit = async (e) => {
        e.preventDefault();

        const payload = {
            post_video: {
                title: videoTitle,
                description: description,
                video_source: videoUrl,
            }
        }

        try {
            const response = await authenticatedRequestInstance(localStorage.getItem('token')).post('/api/v1/post_videos', payload)
            if (response.status === 201) {
                document.getElementById('new-video-modal').close();
                window.location.reload();
            }
        } catch (err) {
            setVideoUrl('');
            setDescription('');
            setVideoTitle('');
            setErrorMessage(err.response.data['message'])
        }
    }

    useEffect(() => {
        setVideoUrl('');
        setDescription('');
        setVideoTitle('');
        setErrorMessage('');
    }, [isSetOpen]);

    return (<>
        <dialog id="new-video-modal" className={`modal ${isSetOpen ? 'open': ''}`}>
            <div className="modal-box">
                <form method="dialog">
                    <button className="btn btn-sm btn-circle btn-ghost absolute right-2 top-2">✕</button>
                </form>
                <h3 className="font-bold text-lg">Add new video</h3>
                <div className="form-control max-w-xl" >
                    <label className="label mt-3">
                        <span className="label-text">Title</span>
                    </label>
                    <input type="text"
                           placeholder="Type here"
                           value={videoTitle}
                           onChange={(e) => setVideoTitle(e.target.value)}
                           className="input input-bordered w-full max-w-xl" />
                    <label className="label mt-3">
                        <span className="label-text">Description</span>
                    </label>
                    <textarea className="textarea textarea-bordered h-24"
                              placeholder="Type here"
                              value={description}
                              onChange={(e) => setDescription(e.target.value)}
                    />
                    <label className="label mt-3">
                        <span className="label-text">URL</span>
                    </label>
                    <input type="text"
                           placeholder="Type here"
                           className="input input-bordered w-full max-w-xl"
                           value={videoUrl}
                           onChange={(e) => setVideoUrl(e.target.value)}
                    />
                    { errorMessage !== undefined && (
                        <label className="label">
                            <span className="label-text-alt text-red-500 text-md font-bold">{errorMessage}</span>
                        </label>
                    )}
                    <button className="mt-8 btn-primary rounded py-3" onClick={handleSubmit}>Share</button>
                </div>
            </div>
        </dialog>
    </>)
};
