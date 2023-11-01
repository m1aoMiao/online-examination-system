import { apis } from ".";

/**
 * 获取整体答题情况
 * @param unit 比赛id
 * @return axios 对象
 */
export const getDetail = (unitId) => {
  return apis({
    method: "get",
    url: "/judger/getList?unitId=" + unitId,
    data: {},
  });
};

/**
 * 获取具体某人的答题情况
 * @param unit 比赛
 * @param stuId 学号
 * @return axios 对象
 */
export const getOneDetail = (unitId, stuId) => {
  return apis({
    method: "get",
    url: "/judger/getOne",
    params: {
      unitId: unitId,
      stuId: stuId,
    },
    data: {},
  });
};

/**
 * 提交批改
 * @param array(id: 题目序号, score: 分数)
 * @return axios对象
 */
export const operatorAnswer = (array, unitId, stuId) => {
  let data = [];
  for (let item of array) {
    data.push({ problemId: item.problemId, score: item.score });
  }
  data = JSON.stringify(data);

  return apis({
    method: "post",
    headers: {
      "content-Type": "application/json",
    },
    url: "/judger/correct",
    params: { unitId, stuId },
    data,
  });
};

/**
 * 通过这个人的学号获取下一个人的学号
 * @param stuId 学号
 * @return axios对象
 */
export const getNextStuId = (stuId) => {
  return apis({
    method: "get",
    url: "/reader/getNextStuId",
    params: { stuId: stuId },
  });
};

/**
 * 错题统计
 * @return list
 */
export const getWrongDetails = () => {
  return apis({
    method: "get",
    url: "/root/uncorrect/list",
  });
};