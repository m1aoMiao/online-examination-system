<template>
  <div class="SubmitPage">
    <div class="success-content">
      <div class="content-body">
        <div class="top-head">
          <p class="body-title">感谢使用在线考试系统测试～</p>
          <el-link :underline="false" @click="dialogTableVisible = true"
            >查看历史成绩</el-link
          >

          <el-dialog title="历史成绩" :visible.sync="dialogTableVisible">
            <el-table :data="historyScores">
              <el-table-column
                property="unit_name"
                label="考试名称"
                width="150"
              ></el-table-column>
              <el-table-column
                property="name"
                label="姓名"
                width="120"
              ></el-table-column>
              <el-table-column
                property="scores"
                label="考试成绩"
              ></el-table-column>
              <el-table-column label="操作">
                <template #default="scope">
                  <el-link
                    class="backBtn"
                    type="primary"
                    :underline="false"
                    @click="showIndex(scope.$index, scope.row)"
                    >查看试卷</el-link
                  >
                </template>
              </el-table-column>
            </el-table>
          </el-dialog>
          <el-link
            class="backBtn"
            type="primary"
            :underline="false"
            @click="back"
            >返回</el-link
          >
        </div>
        <div class="success-body">
          <img
            class="success-img"
            src="../../../public/image/success.png"
            alt=""
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getHistoryScores } from "@/api/user";
export default {
  data() {
    return {
      time: 3,
      dialogTableVisible: false,
      historyScores: [],
    };
  },
  methods: {
    back() {
      this.$router.go(-1);
    },
    showIndex(index, row) {
      this.$router.push(`/userhome/detail/${row.unit_id}/${row.stuId}`);

    },
  },
  async mounted() {
    let {
      data: { data },
    } = await getHistoryScores();
    console.log(data);
    this.historyScores = data;
    this.historyScores.forEach((item) => {
      item.scores = item.unit_score + "/" + item.total_score;
    });
  },
};
</script>

<style scoped>
.SubmitPage {
  display: flex;
  height: 89.6vh;
  flex-direction: column;
  align-items: center;
}
.success-content {
  width: 70vw;
  height: auto;
  background: rgba(255, 255, 255, 1);
  border-radius: 1.4vh;
}
.top-head {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-content: center;
}
.body-title {
  font-size: 3.3vh;
  font-weight: 900;
  letter-spacing: 0px;
  line-height: 0px;
  color: rgba(33, 32, 32, 1);
}
.content-body {
  padding: 4vh 8vh;
}
.success-body {
  margin-top: 3vh;
  width: 100%;
  padding: 7vh 0;
  border-radius: 0.8vh;
  background-color: rgb(214, 214, 214);
  text-align: center;
}
</style>
