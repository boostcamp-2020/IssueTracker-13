import React from 'react';
import { Link } from 'react-router-dom';

export default function PropertyButton({ route, text, img, count }) {
  return (
    <Link to={route}>
      <img src={img}></img>
      {text}
      <span>{count}</span>
    </Link>
  );
}
