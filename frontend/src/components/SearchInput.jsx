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

const Option = styled.option`
  width: 300px;
`;

export default function SearchInput() {
  return (
    <SearchInputDiv>
      <Select>
        <Option>Filters</Option>
        <Option value='Open Issues'>Open Issues</Option>
        <Option value='Your Issues'>Your Issues</Option>
        <Option value='assigned to you'>Everything assigned to you</Option>
        <Option value='mentioning you'>Everything mentioning you</Option>
        <Option value='Closed issues'>Closed issues</Option>
      </Select>
      <Input placeholder="Search all issues" />
    </SearchInputDiv>
  );
}

