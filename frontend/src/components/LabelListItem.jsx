import React from 'react';

import styled from 'styled-components';

const ListItem = styled.div`
  height: 40px;
  display: flex;
  padding: 10px;
  position: relative;
  flex-flow: row nowrap;
  align-items: center;
  border: 1px solid #e1e4e8;
`;

const Title = styled.span`
  padding: 5px 10px;
  font-size: 16px;
  font-weight: 600;
  border-radius: 10px;
  cursor: pointer;
  ${props => `
    color: ${props.color};
    background-color: ${props.backgroundColor};`}
`;

const TitleContainer = styled.div`
  width: 180px;
`;

const ButtonContainer = styled.div`
  display: inline-flex;
  position: absolute;
  gap: 10px;
  right: 10px;
`;

const Description = styled.div`
  color: #6A737D;
  font-size: 16px;
`;

const Button = styled.button`
  padding: 0;
  border: none;
  font-size: 14px;
  background-color: transparent;
  color: #0366D6;
  cursor: pointer;

  ${props => props.isDelete && `
    color: #CB2431;
  `}
`;

export default function LabelListItem({ label }) {
  const { title, description, color, backgroundColor } = label;
  return (
    <ListItem>
      <TitleContainer>
        <Title color={color} backgroundColor={backgroundColor}>{title}</Title>
      </TitleContainer>
      <Description>{description}</Description>
      <ButtonContainer>
        <Button>Edit</Button>
        <Button>Delete</Button>
      </ButtonContainer>
    </ListItem>
  );
}
