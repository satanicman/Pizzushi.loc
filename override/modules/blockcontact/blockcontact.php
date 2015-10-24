<?
class BlockcontactOverride extends Blockcontact{
	public function hookDisplayHeaderRightColumn($params)
	{
		$params['blockcontact_tpl'] = 'nav';
		return $this->hookDisplayRightColumn($params);
	}
}