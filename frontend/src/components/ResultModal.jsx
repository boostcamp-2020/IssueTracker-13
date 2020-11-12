import React from 'react';
import { Link } from 'react-router-dom';

import styled from 'styled-components';

const Page = styled.div`
  position: relative;
  background-color: gray;
  opacity: 0.3;
`;

const Modal = styled.div`
  width: 300px;
  height: 200px;
  background-color: #fff;
  border: 1px solid black;
`;

export default function ResultModal({ description }) {
  return (
    <Page>
      <Modal>
        {description}
        <Link path='/'>
          <button>Home</button>
        </Link>
        <button>취소</button>
      </Modal>
    </Page>
  );
}

