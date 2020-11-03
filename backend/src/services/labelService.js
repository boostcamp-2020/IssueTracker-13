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

const addLabel = async (label) => {
  await Label.create({ ...label, isDeleted: false });
};

const updateLabel = async (label) => {
  const { id, ...rest } = label;
  const [affectedRowCount] = await Label.update(rest, {
    where: { id, isDeleted: false },
  });
  if (affectedRowCount === 0) {
    throw new Error('No rows updated');
  }
};

const deleteLabel = async (label) => {
  const { id } = label;
  const [affectedRowCount] = await Label.update({ isDeleted: true }, {
    where: { id, isDeleted: false },
  });
  if (affectedRowCount === 0) {
    throw new Error('No rows deleted');
  }
};

module.exports = { getLabels, addLabel, updateLabel, deleteLabel };
