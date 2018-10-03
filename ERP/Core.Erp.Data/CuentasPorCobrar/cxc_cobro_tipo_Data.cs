using Core.Erp.Info.CuentasPorCobrar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.CuentasPorCobrar
{
    public class cxc_cobro_tipo_Data
    {
        public List<cxc_cobro_tipo_Info> get_list(bool mostrar_anulados)
        {
            try
            {
                List<cxc_cobro_tipo_Info> Lista;
                using (Entities_cuentas_por_cobrar Context = new Entities_cuentas_por_cobrar())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.cxc_cobro_tipo
                                 select new cxc_cobro_tipo_Info
                                 {
                                     IdCobro_tipo = q.IdCobro_tipo,
                                     tc_abreviatura = q.tc_abreviatura,
                                     tc_Orden = q.tc_Orden,
                                     tc_descripcion = q.tc_descripcion,
                                     Estado = q.Estado,

                                     EstadoBool = q.Estado == "A" ? true : false
                                 }).ToList();
                    else
                        Lista = (from q in Context.cxc_cobro_tipo
                                 where q.Estado == "A"
                                 select new cxc_cobro_tipo_Info
                                 {
                                     IdCobro_tipo = q.IdCobro_tipo,
                                     tc_abreviatura = q.tc_abreviatura,
                                     tc_Orden = q.tc_Orden,
                                     tc_descripcion = q.tc_descripcion,
                                     Estado = q.Estado,

                                     EstadoBool = q.Estado == "A" ? true : false
                                 }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<cxc_cobro_tipo_Info> get_list_retenciones(bool mostrar_anulados)
        {
            try
            {
                List<cxc_cobro_tipo_Info> Lista;
                using (Entities_cuentas_por_cobrar Context = new Entities_cuentas_por_cobrar())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.cxc_cobro_tipo
                                 where q.IdMotivo_tipo_cobro == "RET"
                                 select new cxc_cobro_tipo_Info
                                 {
                                     IdCobro_tipo = q.IdCobro_tipo,
                                     tc_abreviatura = q.tc_abreviatura,
                                     tc_Orden = q.tc_Orden,
                                     tc_descripcion = q.tc_descripcion,
                                     Estado = q.Estado
                                 }).ToList();
                    else
                        Lista = (from q in Context.cxc_cobro_tipo
                                 where q.Estado == "A"
                                 && q.IdMotivo_tipo_cobro == "RET"
                                 select new cxc_cobro_tipo_Info
                                 {
                                     IdCobro_tipo = q.IdCobro_tipo,
                                     tc_abreviatura = q.tc_abreviatura,
                                     tc_Orden = q.tc_Orden,
                                     tc_descripcion = q.tc_descripcion,
                                     Estado = q.Estado
                                 }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public cxc_cobro_tipo_Info get_info(string IdCobro_tipo)
        {
            try
            {
                cxc_cobro_tipo_Info info = new cxc_cobro_tipo_Info();
                using (Entities_cuentas_por_cobrar Context = new Entities_cuentas_por_cobrar())
                {
                    cxc_cobro_tipo Entity = Context.cxc_cobro_tipo.FirstOrDefault(q => q.IdCobro_tipo == IdCobro_tipo);
                    if (Entity == null) return null;
                    info = new cxc_cobro_tipo_Info
                    {
                        IdCobro_tipo = Entity.IdCobro_tipo,
                        ESRetenFTE_bool = Entity.ESRetenFTE == "S" ? true : false,
                        ESRetenIVA_bool = Entity.ESRetenIVA == "S" ? true : false,
                        ESRetenFTE = Entity.ESRetenFTE,
                        ESRetenIVA = Entity.ESRetenIVA,
                        IdMotivo_tipo_cobro = Entity.IdMotivo_tipo_cobro,
                        tc_abreviatura = Entity.tc_abreviatura,
                        tc_Afecha_bool = Entity.tc_Afecha == "S" ? true : false,
                        tc_cobroDirecto_bool = Entity.tc_cobroDirecto == "S" ? true:false,
                        tc_cobroInDirecto_bool = Entity.tc_cobroInDirecto == "S" ? true : false,
                        tc_descripcion = Entity.tc_descripcion,
                        tc_docXCobrar_bool = Entity.tc_docXCobrar == "S" ? true : false,
                        tc_EsCheque_bool = Entity.tc_EsCheque == "S" ? true : false,
                        tc_generaNCAuto_bool = Entity.tc_generaNCAuto == "S" ? true : false,
                        tc_Que_Tipo_Registro_Genera = Entity.tc_Que_Tipo_Registro_Genera,
                        tc_interno_bool = Entity.tc_interno == "S" ? true : false,
                        tc_seCobra_bool = Entity.tc_seCobra == "S" ? true : false,
                        tc_seMuestraManCheque_bool = Entity.tc_seMuestraManCheque == "S" ? true : false,
                        tc_SePuede_Depositar_bool = Entity.tc_SePuede_Depositar == "S" ? true : false,
                        tc_Tomar_Cta_Cble_De = Entity.tc_Tomar_Cta_Cble_De,
                        tc_Orden = Entity.tc_Orden,
                        Estado = Entity.Estado,
                        PorcentajeRet = Entity.PorcentajeRet
                    };
                }
                return info;
            }
            catch (Exception)
            {
                throw;
            }
        }
        public bool validar_existe_IdCobro_tipo(string IdCobro_tipo)
        {
            try
            {
                using (Entities_cuentas_por_cobrar Context = new Entities_cuentas_por_cobrar())
                {
                    var lst = from q in Context.cxc_cobro_tipo
                              where q.IdCobro_tipo == IdCobro_tipo
                              select q;

                    if (lst.Count() > 0)
                        return true;
                    else
                        return false;
                }
            }
            catch (Exception)
            {

                throw;
            }
        }
        //== true ? "S" : "N"
        public bool guardarDB(cxc_cobro_tipo_Info info)
        {
            try
            {
                using (Entities_cuentas_por_cobrar Context = new Entities_cuentas_por_cobrar())
                {
                    cxc_cobro_tipo Entity = new cxc_cobro_tipo
                    {
                        IdCobro_tipo = info.IdCobro_tipo,
                        ESRetenFTE = info.ESRetenFTE_bool == true ? "S" : "N",
                        ESRetenIVA = info.ESRetenIVA_bool == true ? "S" : "N",
                        IdMotivo_tipo_cobro = info.IdMotivo_tipo_cobro,
                        tc_abreviatura = info.tc_abreviatura,
                        tc_Afecha = info.tc_Afecha_bool == true ? "S" : "N",
                        tc_cobroDirecto = info.tc_cobroDirecto_bool == true ? "S" : "N",
                        tc_cobroInDirecto = info.tc_cobroInDirecto_bool == true ? "S" : "N",
                        tc_descripcion = info.tc_descripcion,
                        tc_docXCobrar = info.tc_docXCobrar_bool == true ? "S" : "N",
                        tc_EsCheque = info.tc_EsCheque_bool == true ? "S" : "N",
                        tc_generaNCAuto = info.tc_generaNCAuto_bool == true ? "S" : "N",
                        tc_Que_Tipo_Registro_Genera = info.tc_Que_Tipo_Registro_Genera,
                        tc_interno = info.tc_interno_bool == true ? "S" : "N",
                        tc_seCobra = info.tc_seCobra_bool == true ? "S" : "N",
                        tc_seMuestraManCheque = info.tc_seMuestraManCheque_bool == true ? "S" : "N",
                        tc_SePuede_Depositar = info.tc_SePuede_Depositar_bool == true ? "S" : "N",
                        tc_Tomar_Cta_Cble_De = info.tc_Tomar_Cta_Cble_De,
                        tc_Orden = info.tc_Orden,
                        Estado = info.Estado="A",
                        PorcentajeRet = info.PorcentajeRet,
                         
                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = DateTime.Now
                    };
                    Context.cxc_cobro_tipo.Add(Entity);
                    foreach (var item in info.Lst_tipo_param_det)
                    {
                        cxc_cobro_tipo_Param_conta_x_sucursal det = new cxc_cobro_tipo_Param_conta_x_sucursal
                        {
                            IdEmpresa = info.IdEmpresa,
                            IdSucursal = item.IdSucursal,
                            IdCtaCble = item.IdCtaCble,
                            IdCobro_tipo = info.IdCobro_tipo                            
                        };
                        Context.cxc_cobro_tipo_Param_conta_x_sucursal.Add(det);
                    }
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }
        public bool modificarDB(cxc_cobro_tipo_Info info)
        {
            try
            {
                using (Entities_cuentas_por_cobrar Context = new Entities_cuentas_por_cobrar())
                {
                    cxc_cobro_tipo Entity = Context.cxc_cobro_tipo.FirstOrDefault(q => q.IdCobro_tipo == info.IdCobro_tipo);
                    if (Entity == null) return false;

                    Entity.ESRetenFTE = info.ESRetenFTE_bool == true ? "S" : "N";
                    Entity.ESRetenIVA = info.ESRetenIVA_bool == true ? "S" : "N";
                    Entity.tc_abreviatura = info.tc_abreviatura;
                    Entity.tc_Afecha = info.tc_Afecha_bool == true ? "S" : "N";
                    Entity.tc_cobroDirecto = info.tc_cobroDirecto_bool == true ? "S" : "N";
                    Entity.tc_cobroInDirecto = info.tc_cobroInDirecto_bool == true ? "S" : "N";
                    Entity.tc_descripcion = info.tc_descripcion;
                    Entity.tc_docXCobrar = info.tc_docXCobrar_bool == true ? "S" : "N";
                    Entity.tc_EsCheque = info.tc_EsCheque_bool == true ? "S" : "N";
                    Entity.tc_generaNCAuto = info.tc_generaNCAuto_bool == true ? "S" : "N";
                    Entity.tc_Que_Tipo_Registro_Genera = info.tc_Que_Tipo_Registro_Genera;
                    Entity.tc_interno = info.tc_interno_bool == true ? "S" : "N";
                    Entity.tc_seCobra = info.tc_seCobra_bool == true ? "S" : "N";
                    Entity.tc_seMuestraManCheque = info.tc_seMuestraManCheque_bool == true ? "S" : "N";
                    Entity.tc_SePuede_Depositar = info.tc_SePuede_Depositar_bool == true ? "S" : "N";
                    Entity.tc_Tomar_Cta_Cble_De = info.tc_Tomar_Cta_Cble_De;
                    Entity.tc_Orden = info.tc_Orden;
                    Entity.PorcentajeRet = info.PorcentajeRet;


                    Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    Entity.Fecha_UltMod = info.Fecha_UltMod;

                    var lst = Context.cxc_cobro_tipo_Param_conta_x_sucursal.Where(q => q.IdCobro_tipo == info.IdCobro_tipo && q.IdEmpresa == info.IdEmpresa).ToList();
                    foreach (var item in lst)
                    {
                        Context.cxc_cobro_tipo_Param_conta_x_sucursal.Remove(item);
                    }
                    foreach (var item in info.Lst_tipo_param_det)
                    {
                        cxc_cobro_tipo_Param_conta_x_sucursal det = new cxc_cobro_tipo_Param_conta_x_sucursal
                        {
                            IdEmpresa = info.IdEmpresa,
                            IdSucursal = item.IdSucursal,
                            IdCtaCble = item.IdCtaCble,
                            IdCobro_tipo = info.IdCobro_tipo
                        };
                        Context.cxc_cobro_tipo_Param_conta_x_sucursal.Add(det);
                    }

                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(cxc_cobro_tipo_Info info)
        {
            try
            {
                using (Entities_cuentas_por_cobrar Context = new Entities_cuentas_por_cobrar())
                {
                    cxc_cobro_tipo Entity = Context.cxc_cobro_tipo.FirstOrDefault(q => q.IdCobro_tipo == info.IdCobro_tipo);
                    if (Entity == null) return false;

                    Entity.Estado = info.Estado="I";

                    Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                    Entity.Fecha_UltAnu = info.Fecha_UltAnu;
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}
