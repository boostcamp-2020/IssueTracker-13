const { Label } = require('../db/models');

const getLabels = async () => {
  const labels = await Label.findAll({
    attributes: {
      exclude: ['isDeleted', 'createdAt', 'updatedAt'],
    },
    where: {
      isDeleted: false,
    },
  });
  return labels;
};

const addLabel = async (newLabel) => {
  await Label.create({ ...newLabel, isDeleted: false });
};

const updateLabel = async (modifiedContents) => {
  const { id, ...rest } = modifiedContents;
  const [affectedRowCount] = await Label.update(rest, {
    where: { id, isDeleted: false },
  });
  if (affectedRowCount === 0) {
    throw new Error('No rows updated');
  }
};

const deleteLabel = async (id) => {
  const [affectedRowCount] = await Label.update({ isDeleted: true }, {
    where: { id, isDeleted: false },
  });
  if (affectedRowCount === 0) {
    throw new Error('No rows deleted');
  }
};

module.exports = { getLabels, addLabel, updateLabel, deleteLabel };
