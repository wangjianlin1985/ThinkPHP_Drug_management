<?php
namespace Home\Controller;
use Think\Controller;
class IndexController extends Controller {
    public function index() {
        // if (session("user")) {
        	$this->display("index");
        // } else {
        // 	$this->display("logon");
        // }
    }

    public function logon() {
        $this->display("logon");
    }

    public function userLogon() {
        $data["account"] = array("EQ", $_POST["account"]);
        $data["password"] =  array("EQ", mb_convert_case(md5(md5("medicine").md5($_POST["password"])), MB_CASE_UPPER, "UTF-8"));

        $user = M("User");
        $row = $user->where($data)->select();

        if ($row == null) {
            $this->assign("info", "* 用户名或密码错误！");
            $this->display("logon");
        } else {
            session("user", $row);

            if ($row[0]["grade_id"] == 1) {
                redirect(U("Index/index"));
            } else {
                 redirect(U("Index/userIndex"));
            }
            
        } 
    }

    public function createMedicine() {
        $this->display("createMedicine");
    }

    public function saveMedicine() {
        $medicine = M("Medicine");
        $data["name"] = $_POST["name"];
        $data["status"] = $_POST["status"];
        $data["number"] = $_POST["number"];
        $data["component"] = $_POST["component"];
        $data["effect"] = $_POST["effect"];
        $data["reaction"] = $_POST["reaction"];
        $data["usage"] = $_POST["usage"];
        $data["manufactor"] = $_POST["manufactor"];
        $data["price"] = $_POST["price"];
        $data["amount"] = 0;

        $medicine->add($data);
        $this->display("createMedicine");
    }

    public function searchMedicine() {
        $keyword = $_POST["keyword"];
        $medicine = M("Medicine");
        $rows = array();
        if ($keyword == null || $keyword == "") {
            $rows = $medicine->select();
        } else {
            $data["name"] = array("LIKE", "%" . $keyword . "%");
            $rows = $medicine->where($data)->select();
        }

        $this->assign("medicines", $rows);
        $this->assign("count", $medicine->count());
        $this->display("searchMedicine");
    }

    public function saleMedicine() {
        $medicine = M("Medicine");
        $rows = $medicine->field("id, name")->select();

        $this->assign("medicines", $rows);
        $this->display("saleMedicine");
    }

    public function saveSaleMedicine() {
        $medicineSale = M("MedicineSale");
        $data["medicine_id"] = $_POST["medicineId"];
        $data["amount"] = $_POST["amount"];
        $data["record_time"] = date("Y-m-d H:i:s" ,time());
        $data["user_id"] = 1;

        $medicineSale->add($data);

        $medicine = M("medicine");
        $medicine->execute("UPDATE medicine SET amount = amount - " . $data["amount"] . " WHERE id = " . $data["medicine_id"]);

        redirect("saleMedicine");
    }

    public function searchSaleMedicine() {
        $medicineSale = M("MedicineSale");
        $sql = "";
        $keyword = $_POST["keyword"];

        if ($keyword == null || $keyword == "") {
            $sql = "SELECT m.name, m.status, m.component, m.effect, m.manufactor, m.number, s.amount, s.record_time, u.name AS user_name FROM medicine_sale AS s JOIN medicine AS m JOIN user AS u ON s.medicine_id = m.id AND s.user_id = u.id";
        } else {
            $sql = "SELECT m.name, m.status, m.component, m.effect, m.manufactor, m.number, s.amount, s.record_time, u.name AS user_name FROM medicine_sale AS s JOIN medicine AS m JOIN user AS u ON s.medicine_id = m.id AND s.user_id = u.id WHERE m.name LIKE '%" . $keyword ."%'";
        }
        
        $rows = $medicineSale->query($sql);

        $this->assign("medicineSales", $rows);
        $this->assign("count", $medicineSale->count());

        $this->display("searchSaleMedicine");
    }

    public function searchStock() {
        $medicine = M("Medicine");
        $sql = "";
        $keyword = $_POST["keyword"];

        if ($keyword == null || $keyword == "") {
            $sql = "SELECT m.name, m.status, m.component, m.effect, m.manufactor, m.number, m.amount, SUM(p.amount) AS purchase_amount, SUM(s.amount) AS sale_amount FROM medicine AS m JOIN purchase AS p JOIN medicine_sale AS s ON m.id = p.medicine_id AND m.id = s.medicine_id
                            GROUP BY m.id";
        } else {
            $sql = "SELECT m.name, m.status, m.component, m.effect, m.manufactor, m.number, m.amount, SUM(p.amount) AS purchase_amount, SUM(s.amount) AS sale_amount FROM medicine AS m JOIN purchase AS p JOIN medicine_sale AS s ON m.id = p.medicine_id AND m.id = s.medicine_id
                            WHERE m.name LIKE '%" . $keyword ."%'" . " GROUP BY m.id";
        }
        
        $rows = $medicine->query($sql);

        $this->assign("stocks", $rows);
        $this->assign("count", $medicine->count());

        $this->display("searchStock");
    }

    public function createUser() {
        $this->display("createUser");
    }

    public function saveUser() {
        $user = M("User");
        $data["name"] = $_POST["name"];
        $data["grade_id"] = $_POST["grade_id"];
        $data["account"] = $_POST["account"];
        $data["password"] =  mb_convert_case(md5(md5("medicine").md5($_POST["password"])), MB_CASE_UPPER, "UTF-8");

        $user->add($data);
         $this->display("createUser");
    }

    public function searchUser() {
         $user = M("User");
        $sql = "";
        $keyword = $_POST["keyword"];

        if ($keyword == null || $keyword == "") {
            $sql = "SELECT u.id, u.name, u.account, g.name AS grade FROM user AS u JOIN user_grade AS g ON u.grade_id = g.id";
        } else {
            $sql = "SELECT u.id, u.name, u.account, g.name AS grade FROM user AS u JOIN user_grade AS g ON u.grade_id = g.id WHERE u.name LIKE '%" . $keyword ."%'";
        }
        
        $rows = $user->query($sql);

        $this->assign("users", $rows);
        $this->assign("count", $user->count());
        $this->display("searchUser");
    }

    public function createPurchase() {
        $medicine = M("Medicine");
        $rows = $medicine->field("id, name")->select();

        $this->assign("medicines", $rows);
        $this->display("createPurchase");
    }

    public function savePurchase() {
        $purchase = M("purchase");
        $data["medicine_id"] = $_POST["medicineId"];
        $data["amount"] = $_POST["amount"];
        $data["start_time"] = $_POST["startTime"];
        $data["end_time"] = $_POST["endTime"];
        $data["record_time"] = date("Y-m-d H:i:s" ,time());
        $data["status"] = 0;

        $purchase->add($data);

        $medicine = M("medicine");
        $medicine->execute("UPDATE medicine SET amount = amount + " . $data["amount"] . " WHERE id = " . $data["medicine_id"]);

        redirect("createPurchase");
    }

    public function searchPurchase() {
        $purchase = M("Purchase");
        $sql = "";
        $keyword = $_POST["keyword"];

        if ($keyword == null || $keyword == "") {
            $sql = "SELECT p.id, m.name, m.status, m.component, m.effect, p.start_time, p.end_time, m.manufactor, m.number, p.amount, p.record_time FROM purchase AS p JOIN medicine AS m ON p.medicine_id = m.id";
        } else {
            $sql = "SELECT p.id, m.name, m.status, m.component, m.effect, p.start_time, p.end_time, m.manufactor, m.number, p.amount, p.record_time FROM purchase AS p JOIN medicine AS m ON p.medicine_id = m.id WHERE m.name LIKE '%" . $keyword ."%'";
        }
        
        $rows = $purchase->query($sql);

        $medicine = M("Medicine");
        $this->assign("purchases", $rows);
        $this->assign("count", $medicine->count());
        $this->display("searchPurchase");
    }

    public function processMedicine() {
        $purchase = M("Purchase");
        $sql = "";
        $keyword = $_POST["keyword"];

        if ($keyword == null || $keyword == "") {
            $sql = "SELECT p.id, m.name, m.status, m.component, m.effect, p.start_time, p.end_time, m.manufactor, m.number, p.amount, p.record_time FROM purchase AS p JOIN medicine AS m ON p.medicine_id = m.id WHERE p.end_time < '" . date("Y-m-d" ,time()) . "' AND p.status = 0";
        } else {
            $sql = "SELECT p.id, m.name, m.status, m.component, m.effect, p.start_time, p.end_time, m.manufactor, m.number, p.amount, p.record_time FROM purchase AS p JOIN medicine AS m ON p.medicine_id = m.id WHERE p.end_time < '" . date("Y-m-d" ,time()) . "''  AND p.status = 0 AND m.name LIKE '%" . $keyword ."%'";
        }

        $rows = $purchase->query($sql);
        $count = $purchase->query("SELECT COUNT(*) AS total FROM purchase WHERE end_time < '" . date("Y-m-d" ,time()) . "'");

        $this->assign("purchases", $rows);
        $this->assign("count",  $count[0]["total"]);
        $this->display(processMedicine);
    }

    public function updatePurchaseStatus() {
        $ids = $_GET["ids"];
        $purchase = M("purchase");
        $idArray = explode(",",  $ids);

        for ($i = 0; $i < count($idArray); $i++) {
            $data["id"] = $idArray[$i];
            $data["status"] = 1;
            $data["process_time"] = date("Y-m-d H:i:s" ,time());
            $data["user_id"] = 1;
            $purchase->save($data);
        }        

         redirect(U("Index/processMedicine"));
    }

    public function searchMedicineProcess() {
        $purchase = M("Purchase");

        $sql = "";
        $keyword = $_POST["keyword"];

        if ($keyword == null || $keyword == "") {
            $sql = "SELECT m.name, m.status, m.component, m.effect, p.start_time, p.end_time, m.manufactor, p.amount, p.process_time, u.name AS user_name FROM purchase AS p JOIN medicine AS m JOIN user AS u ON p.medicine_id = m.id AND p.user_id = u.id WHERE p.status = 1";
        } else {
            $sql = "SELECT m.name, m.status, m.component, m.effect, p.start_time, p.end_time, m.manufactor, p.amount, p.process_time, u.name AS user_name FROM purchase AS p JOIN medicine AS m JOIN user AS u ON p.medicine_id = m.id AND p.user_id = u.id WHERE p.status = 1 AND m.name LIKE '%" . $keyword ."%'";
        }

        $rows = $purchase->query($sql);
        $count = $purchase->query("SELECT COUNT(*) AS total FROM purchase WHERE status = 1");

        $this->assign("purchases", $rows);
        $this->assign("count",  $count[0]["total"]);
        $this->display("searchMedicineProcess");
    }

    public function deleteUser() {
        $id = $_GET["id"];

        $user = M("User");
        $user->where("id=" . $id)->delete();
    
        redirect(U("Index/searchUser"));
    }

    public function updateUser() {
        $data["id"] = $_GET["id"];
        $data["name"] = $_POST["new_name"];
        $data["grade_id"] = $_POST["new_grade_id"];

        $user = M("User");
        $user->save($data);

        redirect(U("Index/searchUser"));  
    }
    
    public function updateUserPassword() {
         $data["id"] = $_GET["id"];
         $data["password"] =  mb_convert_case(md5(md5("medicine").md5($_POST["new_password"])), MB_CASE_UPPER, "UTF-8");
         $user = M("User");
         $user->save($data);

         redirect(U("Index/searchUser")); 
    }
}
