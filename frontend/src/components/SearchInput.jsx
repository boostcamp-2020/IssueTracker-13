import React from 'react';

import styled from 'styled-components';

const Select = styled.select`
  padding: 4px 16px;
  width: 100px;
  font-size: 14px;
  font-weight: 500px;
  border: 1px solid #d1d5da;
  border-top-left-radius: 5px;
  border-bottom-left-radius: 5px;
  border-right: none;
  background: none;
  cursor: pointer;
`;

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

export default function SearchInput() {
  return (
    <SearchInputDiv>
      <Select>
        <option>Filters</option>
        <option value='Open Issues'>Open Issues</option>
        <option value='Your Issues'>Your Issues</option>
        <option value='assigned to you'>Everything assigned to you</option>
        <option value='mentioning you'>Everything mentioning you</option>
        <option value='Closed issues'>Closed issues</option>
      </Select>
      <Input placeholder="Search all issues" />
    </SearchInputDiv>
  );
}

