export const SEARCH_INPUT_FILTER = [
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

export const getFilterListOfIssueList = (users, labels, milestones) => [
  {
    title: 'Author',
    contents: [...users],
  },
  {
    title: 'Label',
    contents: [
      { id: 0, title: 'Unabled' },
      ...labels,
    ],
  },
  {
    title: 'Milestones',
    contents: [
      { id: 0, title: 'Issues with no milestone' },
      ...milestones,
    ],
  },
  {
    title: 'Assignee',
    contents: [
      { id: 0, userName: 'Assigned to nobody' },
      ...users,
    ],
  },
];
