<?
class blocksocialOverride extends blocksocial{
	public function install()
	{
		return (parent::install() AND Configuration::updateValue('BLOCKSOCIAL_FACEBOOK', '') && 
			Configuration::updateValue('BLOCKSOCIAL_TWITTER', '') && 
			Configuration::updateValue('BLOCKSOCIAL_RSS', '') && 
			Configuration::updateValue('BLOCKSOCIAL_YOUTUBE', '') && 
			Configuration::updateValue('BLOCKSOCIAL_GOOGLE_PLUS', '') && 
			Configuration::updateValue('BLOCKSOCIAL_PINTEREST', '') && 
			Configuration::updateValue('BLOCKSOCIAL_VIMEO', '') &&
			Configuration::updateValue('BLOCKSOCIAL_INSTAGRAM', '') &&
			Configuration::updateValue('BLOCKSOCIAL_VK', '') &&
			Configuration::updateValue('BLOCKSOCIAL_OD', '') &&
			$this->registerHook('displayHeader') && 
			$this->registerHook('displayFooter'));
	}
	public function uninstall()
	{
		//Delete configuration
		return (Configuration::deleteByName('BLOCKSOCIAL_FACEBOOK') AND 
			Configuration::deleteByName('BLOCKSOCIAL_TWITTER') AND 
			Configuration::deleteByName('BLOCKSOCIAL_RSS') AND 
			Configuration::deleteByName('BLOCKSOCIAL_YOUTUBE') AND 
			Configuration::deleteByName('BLOCKSOCIAL_GOOGLE_PLUS') AND 
			Configuration::deleteByName('BLOCKSOCIAL_PINTEREST') AND
			Configuration::deleteByName('BLOCKSOCIAL_VIMEO') AND
			Configuration::deleteByName('BLOCKSOCIAL_INSTAGRAM') AND
			Configuration::deleteByName('BLOCKSOCIAL_VK') AND
			Configuration::deleteByName('BLOCKSOCIAL_OD') AND
			parent::uninstall());
	}
	public function getContent()
	{
		// If we try to update the settings
		$output = '';
		if (Tools::isSubmit('submitModule'))
		{	
			Configuration::updateValue('BLOCKSOCIAL_FACEBOOK', Tools::getValue('blocksocial_facebook', ''));
			Configuration::updateValue('BLOCKSOCIAL_TWITTER', Tools::getValue('blocksocial_twitter', ''));
			Configuration::updateValue('BLOCKSOCIAL_RSS', Tools::getValue('blocksocial_rss', ''));
			Configuration::updateValue('BLOCKSOCIAL_YOUTUBE', Tools::getValue('blocksocial_youtube', ''));
			Configuration::updateValue('BLOCKSOCIAL_GOOGLE_PLUS', Tools::getValue('blocksocial_google_plus', ''));
			Configuration::updateValue('BLOCKSOCIAL_PINTEREST', Tools::getValue('blocksocial_pinterest', ''));
			Configuration::updateValue('BLOCKSOCIAL_VIMEO', Tools::getValue('blocksocial_vimeo', ''));
			Configuration::updateValue('BLOCKSOCIAL_INSTAGRAM', Tools::getValue('blocksocial_instagram', ''));
			Configuration::updateValue('BLOCKSOCIAL_VK', Tools::getValue('blocksocial_vk', ''));
			Configuration::updateValue('BLOCKSOCIAL_OD', Tools::getValue('blocksocial_od', ''));
			$this->_clearCache('blocksocial.tpl');
			Tools::redirectAdmin($this->context->link->getAdminLink('AdminModules').'&configure='.$this->name.'&tab_module='.$this->tab.'&conf=4&module_name='.$this->name);
		}
		
		return $output.$this->renderForm();
	}
	public function hookDisplayHeaderRightColumn()
	{
		if (!$this->isCached('blocksocial.tpl', $this->getCacheId()))
			$this->smarty->assign(array(
				'facebook_url' => Configuration::get('BLOCKSOCIAL_FACEBOOK'),
				'twitter_url' => Configuration::get('BLOCKSOCIAL_TWITTER'),
				'rss_url' => Configuration::get('BLOCKSOCIAL_RSS'),
				'youtube_url' => Configuration::get('BLOCKSOCIAL_YOUTUBE'),
				'google_plus_url' => Configuration::get('BLOCKSOCIAL_GOOGLE_PLUS'),
				'pinterest_url' => Configuration::get('BLOCKSOCIAL_PINTEREST'),
				'vimeo_url' => Configuration::get('BLOCKSOCIAL_VIMEO'),
				'instagram_url' => Configuration::get('BLOCKSOCIAL_INSTAGRAM'),
				'vk_url' => Configuration::get('BLOCKSOCIAL_VK'),
				'od_url' => Configuration::get('BLOCKSOCIAL_OD'),
			));

		return $this->display(__FILE__, 'blocksocial.tpl', $this->getCacheId());
	}
	public function renderForm()
	{
		$fields_form = array(
			'form' => array(
				'legend' => array(
					'title' => $this->l('Settings'),
					'icon' => 'icon-cogs'
				),
				'input' => array(
					array(
						'type' => 'text',
						'label' => $this->l('Facebook URL'),
						'name' => 'blocksocial_facebook',
						'desc' => $this->l('Your Facebook fan page.'),
					),
					array(
						'type' => 'text',
						'label' => $this->l('Twitter URL'),
						'name' => 'blocksocial_twitter',
						'desc' => $this->l('Your official Twitter account.'),
					),
					array(
						'type' => 'text',
						'label' => $this->l('RSS URL'),
						'name' => 'blocksocial_rss',
						'desc' => $this->l('The RSS feed of your choice (your blog, your store, etc.).'),
					),
					array(
						'type' => 'text',
						'label' => $this->l('YouTube URL'),
						'name' => 'blocksocial_youtube',
						'desc' => $this->l('Your official YouTube account.'),
					),
					array(
						'type' => 'text',
						'label' => $this->l('Google+ URL:'),
						'name' => 'blocksocial_google_plus',
						'desc' => $this->l('Your official Google+ page.'),
					),
					array(
						'type' => 'text',
						'label' => $this->l('Pinterest URL:'),
						'name' => 'blocksocial_pinterest',
						'desc' => $this->l('Your official Pinterest account.'),
					),
					array(						
						'type' => 'text',						
						'label' => $this->l('Vimeo URL:'),						
						'name' => 'blocksocial_vimeo',						
						'desc' => $this->l('Your official Vimeo account.'),					
					),
					array(						
						'type' => 'text',						
						'label' => $this->l('Instagram URL:'),						
						'name' => 'blocksocial_instagram',						
						'desc' => $this->l('Your official Instagram account.'),					
					),
					array(						
						'type' => 'text',						
						'label' => $this->l('VK URL:'),						
						'name' => 'blocksocial_vk',						
						'desc' => $this->l('Your official vk account.'),					
					),
					array(						
						'type' => 'text',						
						'label' => $this->l('odnoclasniki URL:'),						
						'name' => 'blocksocial_od',						
						'desc' => $this->l('Your official odnoclasniki account.'),					
					),
				),
				'submit' => array(
					'title' => $this->l('Save'),
				)
			),
		);
		
		$helper = new HelperForm();
		$helper->show_toolbar = false;
		$helper->table =  $this->table;
		$lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
		$helper->default_form_language = $lang->id;
		$helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') ? Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') : 0;
		$helper->identifier = $this->identifier;
		$helper->submit_action = 'submitModule';
		$helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false).'&configure='.$this->name.'&tab_module='.$this->tab.'&module_name='.$this->name;
		$helper->token = Tools::getAdminTokenLite('AdminModules');
		$helper->tpl_vars = array(
			'fields_value' => $this->getConfigFieldsValues(),
			'languages' => $this->context->controller->getLanguages(),
			'id_language' => $this->context->language->id
		);

		return $helper->generateForm(array($fields_form));
	}
	public function getConfigFieldsValues()
	{
		return array(
			'blocksocial_facebook' => Tools::getValue('blocksocial_facebook', Configuration::get('BLOCKSOCIAL_FACEBOOK')),
			'blocksocial_twitter' => Tools::getValue('blocksocial_twitter', Configuration::get('BLOCKSOCIAL_TWITTER')),
			'blocksocial_rss' => Tools::getValue('blocksocial_rss', Configuration::get('BLOCKSOCIAL_RSS')),
			'blocksocial_youtube' => Tools::getValue('blocksocial_youtube', Configuration::get('BLOCKSOCIAL_YOUTUBE')),
			'blocksocial_google_plus' => Tools::getValue('blocksocial_google_plus', Configuration::get('BLOCKSOCIAL_GOOGLE_PLUS')),
			'blocksocial_pinterest' => Tools::getValue('blocksocial_pinterest', Configuration::get('BLOCKSOCIAL_PINTEREST')),
			'blocksocial_vimeo' => Tools::getValue('blocksocial_vimeo', Configuration::get('BLOCKSOCIAL_VIMEO')),
			'blocksocial_instagram' => Tools::getValue('blocksocial_instagram', Configuration::get('BLOCKSOCIAL_INSTAGRAM')),
			'blocksocial_vk' => Tools::getValue('blocksocial_vk', Configuration::get('BLOCKSOCIAL_VK')),
			'blocksocial_od' => Tools::getValue('blocksocial_od', Configuration::get('BLOCKSOCIAL_OD')),
		);
	}
}