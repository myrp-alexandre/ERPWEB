using Core.Erp.Bus.Presupuesto;
using Core.Erp.Bus.SeguridadAcceso;
using Core.Erp.Info.Presupuesto;
using Core.Erp.Info.SeguridadAcceso;
using Core.Erp.Web.Helps;
using DevExpress.Web;
using DevExpress.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Core.Erp.Web.Areas.Presupuesto.Controllers
{
    public class GrupoPresupuestoController : Controller
    {
        // GET: Presupuesto/GrupoPresupuesto
        #region Variables
        pre_Grupo_Bus bus_Grupo = new pre_Grupo_Bus();
        seg_usuario_Bus bus_usuario = new seg_usuario_Bus();
        pre_GrupoDet_List Lista_GrupoDet = new pre_GrupoDet_List();
        #endregion

        #region Index
        public ActionResult Index()
        {
            return View();
        }

        [ValidateInput(false)]
        public ActionResult GridViewPartial_Grupo()
        {
            int IdEmpresa = Convert.ToInt32(SessionFixed.IdEmpresa);
            List<pre_Grupo_Info> model = bus_Grupo.GetList(IdEmpresa, false);

            return PartialView("_GridViewPartial_Grupo", model);
        }
        #endregion

        #region Metodos ComboBox bajo demanda
        public ActionResult CmbUsuario_Grupo()
        {
            decimal model = new decimal();
            return PartialView("_CmbUsuario_Grupo", model);
        }

        public List<seg_usuario_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args)
        {
            return bus_usuario.get_list_bajo_demanda(args);
        }

        public seg_usuario_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args)
        {
            return bus_usuario.get_info_bajo_demanda(args);
        }
        #endregion

        #region Acciones
        public ActionResult Nuevo(int IdEmpresa = 0)
        {
            #region Validar Session
            if (string.IsNullOrEmpty(SessionFixed.IdTransaccionSession))
                return RedirectToAction("Login", new { Area = "", Controller = "Account" });
            SessionFixed.IdTransaccionSession = (Convert.ToDecimal(SessionFixed.IdTransaccionSession) + 1).ToString();
            SessionFixed.IdTransaccionSessionActual = SessionFixed.IdTransaccionSession;
            #endregion

            pre_Grupo_Info model = new pre_Grupo_Info
            {
                IdEmpresa = IdEmpresa,
                IdTransaccionSession = Convert.ToDecimal(SessionFixed.IdTransaccionSession),               
                IdUsuarioCreacion = SessionFixed.IdUsuario
            };

            Lista_GrupoDet.set_list(new List<pre_Grupo_x_seg_usuario_Info>(), model.IdTransaccionSession);
            return View(model);
        }
        [HttpPost]
        public ActionResult Nuevo(pre_Grupo_Info model)
        {
            model.ListaGrupoDetalle = Lista_GrupoDet.get_list(model.IdTransaccionSession);

            if (!bus_Grupo.GuardarBD(model))
            {
                SessionFixed.IdTransaccionSessionActual = model.IdTransaccionSession.ToString();
                return View(model);
            }

            return RedirectToAction("Index");
        }
        #endregion

        #region Metodos del detalle
        public ActionResult GridViewPartial_GrupoDet()
        {
            SessionFixed.IdTransaccionSessionActual = Request.Params["TransaccionFixed"] != null ? Request.Params["TransaccionFixed"].ToString() : SessionFixed.IdTransaccionSessionActual;
            var model = Lista_GrupoDet.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            return PartialView("_GridViewPartial_GrupoDet", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] pre_Grupo_x_seg_usuario_Info info_det)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (info_det != null)
                if (info_det.IdUsuario != "")
                {
                    seg_usuario_Info info_Usuario = bus_usuario.get_info(info_det.IdUsuario);
                    if (info_Usuario != null)
                    {
                        info_det.IdUsuario = info_Usuario.IdUsuario;
                        info_det.Nombre = info_Usuario.Nombre;
                    }
                }

                Lista_GrupoDet.AddRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            var model = Lista_GrupoDet.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));

            return PartialView("_GridViewPartial_GrupoDet", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult EditingUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] pre_Grupo_x_seg_usuario_Info info_det)
        {
            int IdEmpresa = Convert.ToInt32(Session["IdEmpresa"]);
            if (info_det != null)
                if (info_det.IdUsuario != "")
                {
                    seg_usuario_Info info_Usuario = bus_usuario.get_info(info_det.IdUsuario);
                    if (info_Usuario != null)
                    {
                        info_det.IdUsuario = info_Usuario.IdUsuario;
                        info_det.Nombre = info_Usuario.Nombre;
                    }
                }
                Lista_GrupoDet.UpdateRow(info_det, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            var model = Lista_GrupoDet.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));

            return PartialView("_GridViewPartial_GrupoDet", model);
        }

        public ActionResult EditingDelete(int Secuencia)
        {
            Lista_GrupoDet.DeleteRow(Secuencia, Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));
            pre_Grupo_Info model = new pre_Grupo_Info();
            model.ListaGrupoDetalle = Lista_GrupoDet.get_list(Convert.ToDecimal(SessionFixed.IdTransaccionSessionActual));

            return PartialView("_GridViewPartial_GrupoDet", model.ListaGrupoDetalle);
        }
        #endregion        
    }

    public class pre_GrupoDet_List
    {
        string Variable = "pre_Grupo_x_seg_usuario_Info";
        public List<pre_Grupo_x_seg_usuario_Info> get_list(decimal IdTransaccionSession)
        {

            if (HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] == null)
            {
                List<pre_Grupo_x_seg_usuario_Info> list = new List<pre_Grupo_x_seg_usuario_Info>();

                HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
            }
            return (List<pre_Grupo_x_seg_usuario_Info>)HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()];
        }

        public void set_list(List<pre_Grupo_x_seg_usuario_Info> list, decimal IdTransaccionSession)
        {
            HttpContext.Current.Session[Variable + IdTransaccionSession.ToString()] = list;
        }

        public void AddRow(pre_Grupo_x_seg_usuario_Info info_det, decimal IdTransaccionSession)
        {
            List<pre_Grupo_x_seg_usuario_Info> list = get_list(IdTransaccionSession);
            info_det.Secuencia = list.Count == 0 ? 1 : list.Max(q => q.Secuencia) + 1;
            info_det.IdUsuario = info_det.IdUsuario;
            info_det.Nombre = info_det.Nombre;

            list.Add(info_det);
        }

        public void UpdateRow(pre_Grupo_x_seg_usuario_Info info_det, decimal IdTransaccionSession)
        {
            pre_Grupo_x_seg_usuario_Info edited_info = get_list(IdTransaccionSession).Where(m => m.Secuencia == info_det.Secuencia).First();
            edited_info.IdUsuario = info_det.IdUsuario;
            edited_info.Nombre = info_det.Nombre;
        }

        public void DeleteRow(int Secuencia, decimal IdTransaccionSession)
        {
            List<pre_Grupo_x_seg_usuario_Info> list = get_list(IdTransaccionSession);
            list.Remove(list.Where(m => m.Secuencia == Secuencia).First());
        }
    }
}