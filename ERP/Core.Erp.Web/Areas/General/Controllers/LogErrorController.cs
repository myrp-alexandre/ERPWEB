using Core.Erp.Info.General;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.General.Controllers
{
    public class LogErrorController : Controller
    {
        // GET: General/LogError
        public ActionResult Index()
        {
            tb_sis_log_error_Info model = new tb_sis_log_error_Info();
            model.DescripcionError = tb_sis_log_error_InfoList.DescripcionError;
            return View(model);
        }

        
    }

    
}