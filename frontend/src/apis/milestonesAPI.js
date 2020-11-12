import axios from 'axios';

const getMilestones = async () => {
  const { data } = await axios.get('/api/milestones');
  return data;
};

const closeMilestone = async (id) => {
  const requestBody = {
    id,
    isOpen: false,
  };
  const { message } = await axios.put('/api/milestones', requestBody);
  return message;
};

const openMilestone = async (id) => {
  const requestBody = {
    id,
    isOpen: true,
  };
  const { message } = await axios.put('/api/milestones', requestBody);
  return message;
};

const deleteMilestone = async (id) => {
  const { message } = await axios.delete(`/api/milestones/${id}`);
  return message;
};

export {
  getMilestones,
  closeMilestone,
  deleteMilestone,
  openMilestone,
};
