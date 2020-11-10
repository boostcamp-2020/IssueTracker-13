import React, { useState } from 'react';

import styled from 'styled-components';

import FilterModal from './FilterModal';

const Input = styled.input`
  padding: 5px 12px;
  width: 85%;
  border: 1px solid #d1d5da;
  background-color: #FAFBFC;
  border-top-right-radius: 5px;
  border-bottom-right-radius: 5px;
  font-size: 14px;
  font-weight: 500px;
`;

const SearchInputDiv = styled.div`
  width: 70%;
`;

const FilterButton = styled.button`
  padding: 4px 8px;
  cursor: pointer;
`;

export default function SearchInput() {
  const [isShowModal, setIsShowModal] = useState(false);
  const title = 'Filter Issues';
  const contents = [
    {
      title: 'Open issues',
      query: 'isOpen=true',
    },
    {
      title: 'Your issues',
      query: 'author=parkdit94',
    },
    {
      title: 'Everything assigned to you',
      query: 'isOpen=true',
    },
    {
      title: 'Everythong mentioning you',
      query: 'isOpen=true',
    },
    {
      title: 'Closed issues',
      query: 'isOpen=false',
    },
  ];

  return (
    <SearchInputDiv>
      <FilterButton onClick={() => setIsShowModal(!isShowModal)}>Filters</FilterButton>
      {isShowModal &&
        <FilterModal
          title={title}
          contents={contents}
          setIsShowModal={setIsShowModal}
        />}
      <Input placeholder="Search all issues" />
    </SearchInputDiv>
  );
}
