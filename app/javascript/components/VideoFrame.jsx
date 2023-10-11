import moment from "moment";
import React, {useEffect, useState} from "react";

export default ({ video }) => (
    <div className="object-center card sm:card-side bg-base-100 shadow-xl my-10">
        <iframe
            className="aspect-video"
            width="60%"
            height="600"
            src={video.url}
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
            allowFullScreen="allowFullScreen"
        />
        <div className="card-body">
            <h2 className="card-title">{video.title}</h2>
            <p className="card-text">{video.description}</p>
            <div className="d-flex justify-content-between align-items-center">
                <p className="card-text text-xs">{`Shared by ${video.shared_by}`}</p>
                <small className="card-text text-body-secondary">{ moment(video.created_at).fromNow() }</small>
            </div>
        </div>
    </div>
)