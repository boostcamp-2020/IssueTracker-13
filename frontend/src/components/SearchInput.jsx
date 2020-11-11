import React, { useState, useContext } from 'react';

import styled from 'styled-components';

import FilterModal from './FilterModal';

import { IssuesContext } from '../pages/IssueListPage';

import { SEARCH_INPUT_FILTER } from '../assets/filter';

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
  const { query } = useContext(IssuesContext);

  const title = 'Filter Issues';

  const inputQuery = query.length > 0 ? query.split('&').join(' ').split('=').join(':') : '';

  return (
    <SearchInputDiv>
      <FilterButton onClick={() => setIsShowModal(!isShowModal)}>Filters</FilterButton>
      {isShowModal &&
        <FilterModal
          title={title}
          contents={SEARCH_INPUT_FILTER}
          setIsShowModal={setIsShowModal}
        />}
      <Input placeholder="Search all issues" value={inputQuery} readOnly/>
    </SearchInputDiv>
  );
}
