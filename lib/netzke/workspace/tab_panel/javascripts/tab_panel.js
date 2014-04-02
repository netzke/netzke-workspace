{
  /**
   * Loads a component.
   */
  loadTab: function(cmp, options) {
    var receivingTab;

    options = options || {};

    if (options.newTab) {
      receivingTab = this.add({layout: 'fit', closable: true});
    } else {
      receivingTab = this.getActiveTab();
      if (!this.isDynamic(receivingTab)) return;
    }

    this.suspendEvents();
    this.setActiveTab(receivingTab);
    this.resumeEvents();

    receivingTab.setTitle('Loading...');

    receivingTab.removeAll();

    var clientConfig = Ext.apply(options.clientConfig, {
      klass: cmp
    });

    this.netzkeLoadComponent("tab", {
      clientConfig: clientConfig,
      container: receivingTab,
      clone: true,
      scope: this,
      callback: function(c) {
        receivingTab.setTitle(c.title);
        receivingTab.componentConfig = clientConfig;
        this.saveTabs();
      }
    });
  },

  /**
   * Closes all tabs
   */
  closeAllTabs: function() {
    this.items.each(function(tab, i) {
      if (this.isDynamic(tab)) {
        this.remove(tab);
      }
    }, this)
    this.saveTabs();
  },

  /**
  * private methods
  */

  initComponent: function() {
    this.callParent();

    this.on('tabchange', this.onTabChange, this);

    this.on('remove', function(me, tab) {
      this.saveTabs();
    }, this);

    this.addInitialTabs();
  },

  addInitialTabs: function(){
    if (this.tabs) {
      this.tabs.forEach(function(c) {
        var tab = this.add({layout: 'fit', closable: true, title: c.title, active: c.active, componentConfig: c});
        if (c.active) this.setActiveTab(tab);
      }, this);
    }
  },

  onTabChange: function(panel, tab){
    if (tab.items.getCount() == 0 && this.isDynamic(tab)) {
      // this tab is nesting no component yet
      this.netzkeLoadComponent("tab", {container: tab, clientConfig: tab.componentConfig, clone: true});
    }

    this.saveTabs();
  },

  // Returns true if given tab was dynamically loaded (as opposed to tabs that could be there initially)
  isDynamic: function(tab){
    return !!tab.componentConfig;
  },

  // Saves current tab configs to server
  saveTabs: function() {
    var activeTab = this.getActiveTab();
    var configs = [];
    this.items.each(function(tab, i){
      if (this.isDynamic(tab)) {
        var tabConfig = tab.componentConfig || {};
        tabConfig.title = tab.title;
        tabConfig.active = activeTab == tab;
        configs.push(tabConfig);
      }
    }, this);

    this.serverSaveTabs(configs);
  }
}
