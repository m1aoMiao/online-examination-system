import { apis } from ".";

/**
 * 用户获取题目列表
 * @param unit 比赛id
 * @return axios 对象
 */
export const getCompetetionListDetail = (unitId) => {
  unitId = Number(unitId);
  return apis({
    method: "get",
    url: "/normal/getList?unitId=" + unitId,
    data: {},
  });
};

/**
 * 用户提交答案
 * @param 用户答案
 * @return axios 对象
 */
export const userAnswerSubmit = (array, unitId) => {
  return apis({
    method: "post",
    url: "/normal/commitAnswer",
    data: array,
    params: {
      unitId: unitId,
    },
  });
};

/**
 * 用户提交答案（自动批改）
 * @param 用户答案
 * @return axios 对象
 */
export const autoJudge = (array, unitId) => {
  return apis({
    method: "post",
    url: "/normal/commitAnswer",
    data: array,
    params: {
      unitId: unitId,
    },
  });
};

/**
 * 获取历史成绩
 * @param token
 * @return 历史成绩
 */
export const getHistoryScores = () => {
  return apis({
    method: "get",
    url: "/normal/score/list",
  });
};

/**
 * 获取历史成绩详情
 * @param token
 * @return 历史成绩详情
 */
export const getExamDetail = (unitId) => {
  return apis({
    method: "get",
    url: "/normal/getList",
    params:{
      unitId
    }
  });
};
