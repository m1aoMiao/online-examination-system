<template>
  <div id="answerDetail">
    <div class="detail-body">
      <div class="body-head">
        <div>
          <span class="body-title">{{ title }}</span>
          <el-link
          style="margin-left: 10px;"
            class="nextBtn"
            type="primary"
            @click="showWrongDetail"
            :underline="false"
            >错题统计</el-link
          >
        </div>
        <el-dialog title="错题统计" :visible.sync="dialogTableVisible">
          <el-table :data="questionList" height="250">
            <el-table-column
              property="problem_id"
              label="题号"
              width="150"
            ></el-table-column>
            <el-table-column
              property="problem_description"
              label="题目"
              width="150"
            ></el-table-column>
            <el-table-column
              property="uncorrect_num"
              label="错题人数"
            ></el-table-column>
          </el-table>
        </el-dialog>
        <div class="space"></div>
        <el-link class="backBtn" type="primary" :underline="false" @click="back"
          >返回</el-link
        >
      </div>
      <div class="body-main">
        <el-table stripe height="80vh" :data="table" style="width: 100%">
          <el-table-column prop="stuId" label="学号"> </el-table-column>
          <el-table-column prop="process" label="题目完成度"> </el-table-column>
          <el-table-column
            prop="process_correcting"
            label="批改情况"
          ></el-table-column>
          <el-table-column prop="scores" label="得分情况"> </el-table-column>

          <el-table-column fixed="right" label="操作" key="slot">
            <template #default="scope">
              <el-button
                size="mini"
                type="primary"
                plain
                @click="showIndex(scope.$index, scope.row)"
                cursor:pointer
                >查看</el-button
              >
            </template>
          </el-table-column>
        </el-table>
        <div class="describe_info">
          <h2>学号筛选试卷</h2>
          <div class="search">
            <el-input
              placeholder="请输入要查询的学号"
              v-model="searchUid"
              @input="searchOne"
              clearable
            ></el-input>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getDetail,getWrongDetails } from "../../api/operator";
export default {
  name: "OperatorAnswer",
  data() {
    return {
      title: this.$route.query.unit_name,
      peopleNum: "",
      processedNot: "",
      tableData: [],
      table: [],
      searchUid: "",
      dialogTableVisible: false,
      questionList:[]
    };
  },
  methods: {
    async showWrongDetail() {
      this.dialogTableVisible = true;
      let {data:{data}} = await getWrongDetails()
      let i = 0
      data.forEach(item => {
        item.problem_id = ++i
      });
      this.questionList = data
    },
    back() {
      this.$router.push("/operatorhome");
      location.reload();
    },
    showIndex(index, row) {
      this.$router.push(
        `/operatorhome/answer/${this.$router.currentRoute.params.unitId}/${row.stuId}`
      );
    },
    searchOne() {
      this.table = this.tableData.filter((item) => {
        console.log(item);
        if (item.stuId.indexOf(this.searchUid) !== -1) {
          return item;
        }
      });
    },
  },
  mounted() {
    if (localStorage.getItem("role") === "1") {
      getDetail(this.$router.currentRoute.params.unitId).then((res) => {
        const data = res.data.data;
        console.log(data);
        // console.log(location);
        for (let i = 0; i < data.stu_list.length; i++) {
          data.stu_list[i].process =
            data.stu_list[i].finishedQuestionNum +
            "/" +
            data.stu_list[i].totalQuestionNum;
          data.stu_list[i].process_correcting =
            data.stu_list[i].finishedCorrectNum +
            "/" +
            data.stu_list[i].totalQuestionNum;
          data.stu_list[i].scores =
            data.stu_list[i].unitScore + "/" + data.stu_list[i].totalScore;
        }
        this.peopleNum = data.tota_account_num;
        this.processedNot = data.total_problem_num;
        this.table = data.stu_list;
        this.tableData = data.stu_list;
      });
    } else {
      this.$router.back();
    }
  },
};
</script>

<style scoped>
#answerDetail {
  margin: auto;
  width: 60vw;
  background: #fff;
  padding: 4vh;
  border-radius: 0.5vw;
}
.body-head {
  display: flex;
  flex-direction: row;
  justify-content: space-around;
  margin: 3vh 0;
}
.body-title {
  font-size: 3.3vh;
  font-weight: 900;
  letter-spacing: 0px;
  line-height: 0px;
  color: rgba(33, 32, 32, 1);
}
.space {
  margin: auto;
}
.body-main {
  z-index: -10;
  display: flex;
  flex-direction: row;
}
.describe_info {
  margin-left: 2vw;
}

::v-deep .el-table th.el-table__cell > .cell {
  white-space: nowrap;
}

.el-table thead tr {
  background-color: #f5f5f5 !important;
}
tr:nth-child(even) {
  background: #f5f5f5;
}
.el-table .success-row {
  background: #ffffff;
}
.search {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
</style>
