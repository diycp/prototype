<?php

namespace app\admin\controller;

use think\Request;
use think\Loader;

/**
 * Description of Error
 * 空控制器
 * @author static7
 */
class Error extends Admin {

    /**
     * 空操作
     * @author staitc7 <static7@qq.com>
     * @return mixed   
     */
    public function index(Request $request) {
        return $this->unify(Loader::parseName($request->controller()));
    }

    /**
     * 统一回复
     * @param mixed $param 参数
     * @author staitc7 <static7@qq.com>
     * @return mixed   
     */
    protected function unify($param = "") {
        return $this->view->assign(['info' => $param])->fetch('common/error');
    }

}
