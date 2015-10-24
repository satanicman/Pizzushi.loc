<?php
class BlockUserInfoOverride extends BlockUserInfo{
	public function hookRightColumn($params)
	{
		return $this->display(__FILE__, 'nav.tpl');
	}
}