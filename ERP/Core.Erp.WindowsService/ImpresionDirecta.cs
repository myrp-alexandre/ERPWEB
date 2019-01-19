using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using System.Timers;

namespace Core.Erp.WindowsService
{
    public partial class ImpresionDirecta : ServiceBase
    {
        public ImpresionDirecta()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            Timer aTimer = new System.Timers.Timer();
            aTimer.Elapsed += new ElapsedEventHandler(OnTimedEvent);
            aTimer.Interval = TimeSpan.FromSeconds(5).TotalMilliseconds;
            aTimer.Enabled = true;
        }

        private void OnTimedEvent(object sender, ElapsedEventArgs e)
        {
            
        }

        protected override void OnStop()
        {
        }
    }
}
