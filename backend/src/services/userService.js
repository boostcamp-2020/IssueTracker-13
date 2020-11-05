const { User } = require('../db/models');


const getUsers = async () => {
  const users = await User.findAll({
    attributes: {
      exclude: ['isDeleted', 'createdAt', 'updatedAt'],
    },
    where: {
      isDeleted: false,
    },
  });
  return users;
};

const updateUser = async (modifiedContents) => {
  const { id, ...rest } = modifiedContents;
  const [affectedRowCount] = await User.update(rest, {
    where: { id, isDeleted: false },
  });
  if (affectedRowCount === 0) {
    throw new Error('No rows updated');
  }
};

const deleteUser = async (id) => {
  const [affectedRowCount] = await User.update({ isDeleted: true }, {
    where: { id, isDeleted: false },
  });
  if (affectedRowCount === 0) {
    throw new Error('No rows deleted');
  }
};

module.exports = { getUsers, updateUser, deleteUser };