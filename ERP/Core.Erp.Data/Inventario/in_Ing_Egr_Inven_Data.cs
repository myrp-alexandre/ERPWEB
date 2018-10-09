using Core.Erp.Info.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Inventario
{
    public class in_Ing_Egr_Inven_Data
    {
        public List<in_Ing_Egr_Inven_Info> get_list (int IdEmpresa, string signo, bool mostrar_anulados, DateTime fecha_ini, DateTime fecha_fin)
        {
            try
            {
                fecha_ini = fecha_ini.Date;
                fecha_fin = fecha_fin.Date;
                List<in_Ing_Egr_Inven_Info> Lista;
                using (Entities_inventario Context = new Entities_inventario())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.in_Ing_Egr_Inven
                                 join t in Context.in_movi_inven_tipo
                                 on new { q.IdEmpresa, q.IdMovi_inven_tipo} equals new { t.IdEmpresa, t.IdMovi_inven_tipo}
                                 where q.IdEmpresa == IdEmpresa
                                 && q.signo == signo 
                                 && fecha_ini <= q.cm_fecha && q.cm_fecha <= fecha_fin
                                 orderby new { q.cm_fecha } descending
                                 select new in_Ing_Egr_Inven_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdSucursal = q.IdSucursal,
                                     IdMovi_inven_tipo = q.IdMovi_inven_tipo,
                                     IdBodega = q.IdBodega,
                                     IdNumMovi = q.IdNumMovi,
                                     IdMotivo_Inv = q.IdMotivo_Inv,
                                     Estado = q.Estado,
                                     signo = q.signo,
                                     cm_observacion = q.cm_observacion,
                                     CodMoviInven = q.CodMoviInven,
                                     cm_fecha = q.cm_fecha,
                                     tm_descripcion = t.tm_descripcion,

                                     EstadoBool = q.Estado == "A" ? true : false

                                 }).ToList();

                    else
                        Lista = (from q in Context.in_Ing_Egr_Inven
                                 join t in Context.in_movi_inven_tipo
                                 on new { q.IdEmpresa, q.IdMovi_inven_tipo } equals new { t.IdEmpresa, t.IdMovi_inven_tipo }
                                 where q.IdEmpresa == IdEmpresa
                                 && q.signo == signo
                                 && fecha_ini <= q.cm_fecha && q.cm_fecha <= fecha_fin
                                 && q.Estado == "A"
                                 orderby new { q.cm_fecha } descending
                                 select new in_Ing_Egr_Inven_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdSucursal = q.IdSucursal,
                                     IdMovi_inven_tipo = q.IdMovi_inven_tipo,
                                     IdBodega = q.IdBodega,
                                     IdNumMovi = q.IdNumMovi,
                                     IdMotivo_Inv = q.IdMotivo_Inv,
                                     Estado = q.Estado,
                                     signo = q.signo,
                                     cm_observacion = q.cm_observacion,
                                     CodMoviInven = q.CodMoviInven,
                                     cm_fecha = q.cm_fecha,
                                     tm_descripcion = t.tm_descripcion,

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

        public in_Ing_Egr_Inven_Info get_info(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, decimal IdNumMovi)
        {
            try
            {
                in_Ing_Egr_Inven_Info info = new in_Ing_Egr_Inven_Info();
                using (Entities_inventario Context = new Entities_inventario())
                {
                    in_Ing_Egr_Inven Entity = Context.in_Ing_Egr_Inven.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdSucursal == IdSucursal && q.IdMovi_inven_tipo == IdMovi_inven_tipo && q.IdNumMovi == IdNumMovi);
                    if (Entity == null) return null;
                    info = new in_Ing_Egr_Inven_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdSucursal = Entity.IdSucursal,
                        IdMovi_inven_tipo = Entity.IdMovi_inven_tipo,
                        IdBodega = Entity.IdBodega,
                        IdNumMovi = Entity.IdNumMovi,
                        IdMotivo_Inv = Entity.IdMotivo_Inv,
                        cm_fecha = Entity.cm_fecha,
                        cm_observacion = Entity.cm_observacion,
                        CodMoviInven = Entity.CodMoviInven,
                        Estado = Entity.Estado,
                        IdResponsable = Entity.IdResponsable,
                        signo = Entity.signo
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        private decimal get_id(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo)
        {
            try
            {
                decimal ID = 1;
                using (Entities_inventario Context = new Entities_inventario())
                {
                    var lst = from q in Context.in_Ing_Egr_Inven
                              where q.IdEmpresa == IdEmpresa
                              && q.IdSucursal == IdSucursal
                              && q.IdMovi_inven_tipo == IdMovi_inven_tipo
                              select q;
                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdNumMovi) + 1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(in_Ing_Egr_Inven_Info info, string signo)
        {
            try
            {
                in_producto_x_tb_bodega_Costo_Historico_Data data_costo = new in_producto_x_tb_bodega_Costo_Historico_Data();
                int sec = 1;
                using (Entities_inventario Context = new Entities_inventario())
                {
                    in_Ing_Egr_Inven Entity = new in_Ing_Egr_Inven
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdSucursal = info.IdSucursal,
                        IdMovi_inven_tipo = info.IdMovi_inven_tipo,
                        IdNumMovi = info.IdNumMovi = get_id(info.IdEmpresa, info.IdSucursal, info.IdMovi_inven_tipo),
                        IdBodega = info.IdBodega,
                        IdMotivo_Inv = info.IdMotivo_Inv,
                        cm_fecha = info.cm_fecha.Date,
                        cm_observacion = info.cm_observacion,
                        CodMoviInven = info.CodMoviInven,
                        Estado = info.Estado = "A",
                        IdResponsable = info.IdResponsable,
                        signo = info.signo,

                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = DateTime.Now
                    };
                    Context.in_Ing_Egr_Inven.Add(Entity);

                    foreach (var item in info.lst_in_Ing_Egr_Inven_det)
                    {
                        if (signo == "-")
                            item.mv_costo = data_costo.get_ultimo_costo(info.IdEmpresa, info.IdSucursal, Convert.ToInt32(info.IdBodega), item.IdProducto, info.cm_fecha);
                        in_Ing_Egr_Inven_det entity_det = new in_Ing_Egr_Inven_det
                        {
                            
                            IdEmpresa = info.IdEmpresa,
                            IdSucursal = info.IdSucursal,
                            IdMovi_inven_tipo = info.IdMovi_inven_tipo,
                            IdNumMovi = info.IdNumMovi,
                            Secuencia = sec,
                            IdBodega =(int) info.IdBodega,
                            IdProducto = item.IdProducto,

                            IdCentroCosto = item.IdCentroCosto,
                            IdCentroCosto_sub_centro_costo = item.IdCentroCosto_sub_centro_costo,
                            IdPunto_cargo = item.IdPunto_cargo,
                            IdPunto_cargo_grupo = item.IdPunto_cargo_grupo,

                            dm_observacion = item.dm_observacion,
                            IdMotivo_Inv = info.IdMotivo_Inv,
                            IdEstadoAproba = "APRO",
                            Motivo_Aprobacion = item.Motivo_Aprobacion,

                            IdEmpresa_oc = item.IdEmpresa_oc,
                            IdSucursal_oc = item.IdSucursal_oc,
                            IdOrdenCompra = item.IdOrdenCompra,
                            Secuencia_oc = item.Secuencia_oc,

                            IdEmpresa_inv = item.IdEmpresa_inv,
                            IdSucursal_inv = item.IdSucursal_inv,
                            IdBodega_inv = item.IdBodega_inv,
                            IdMovi_inven_tipo_inv = item.IdMovi_inven_tipo_inv,
                            IdNumMovi_inv = item.IdNumMovi_inv,
                            secuencia_inv = item.secuencia_inv,

                            dm_cantidad_sinConversion = Math.Abs(item.dm_cantidad_sinConversion) * (info.signo == "-" ? -1 : 1),
                            dm_cantidad = Math.Abs(item.dm_cantidad) * (info.signo == "-" ? -1 : 1),

                            IdUnidadMedida  = (item.IdUnidadMedida)==null? "UNID":item.IdUnidadMedida,
                            IdUnidadMedida_sinConversion = (item.IdUnidadMedida_sinConversion) == null ? "UNID" : item.IdUnidadMedida_sinConversion,
                            mv_costo_sinConversion = (item.mv_costo_sinConversion)==null ? 0 : item.mv_costo_sinConversion,
                            mv_costo = item.mv_costo,

                        };
                        Context.in_Ing_Egr_Inven_det.Add(entity_det);
                        sec++;
                    }
                    Context.SaveChanges();

                    // ejecutando el sp para in_movi_det
                    Context.spINV_aprobacion_ing_egr(info.IdEmpresa, info.IdSucursal, info.IdBodega, info.IdMovi_inven_tipo, info.IdNumMovi);
                }
                return true;
            }
            catch (Exception EX)
            {

                throw;
            }
        }

        public bool modificarDB(in_Ing_Egr_Inven_Info info)
        {
            try
            {
                int sec = 1;
                Reversar_Aprobacion(info.IdEmpresa, info.IdSucursal, info.IdMovi_inven_tipo, info.IdNumMovi, "");

                using (Entities_inventario Context = new Entities_inventario())
                {
                    in_Ing_Egr_Inven Entity = Context.in_Ing_Egr_Inven.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdSucursal == info.IdSucursal && q.IdMovi_inven_tipo == info.IdMovi_inven_tipo && q.IdNumMovi == info.IdNumMovi);
                    if (Entity == null) return false;

                    Entity.cm_observacion = info.cm_observacion;
                    Entity.CodMoviInven = info.CodMoviInven;
                    Entity.cm_fecha = info.cm_fecha.Date;
                    Entity.IdResponsable = info.IdResponsable;
                    Entity.IdMotivo_Inv = info.IdMotivo_Inv;
                    Entity.IdBodega = info.IdBodega;
                    Entity.IdUsuarioUltModi = info.IdUsuarioUltModi;
                    Entity.Fecha_UltMod = DateTime.Now;

                    var lst = Context.in_Ing_Egr_Inven_det.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdSucursal == info.IdSucursal && q.IdMovi_inven_tipo == info.IdMovi_inven_tipo && q.IdNumMovi == info.IdNumMovi);
                    Context.in_Ing_Egr_Inven_det.RemoveRange(lst);

                    foreach (var item in info.lst_in_Ing_Egr_Inven_det)
                    {
                        Context.in_Ing_Egr_Inven_det.Add(new in_Ing_Egr_Inven_det
                        {
                            IdEmpresa = info.IdEmpresa,
                            IdSucursal = info.IdSucursal,
                            IdMovi_inven_tipo = info.IdMovi_inven_tipo,
                            IdNumMovi = info.IdNumMovi,
                            Secuencia = sec,
                            IdBodega = (int)info.IdBodega,
                            IdProducto = item.IdProducto,

                            IdCentroCosto = item.IdCentroCosto,
                            IdCentroCosto_sub_centro_costo = item.IdCentroCosto_sub_centro_costo,
                            IdPunto_cargo = item.IdPunto_cargo,
                            IdPunto_cargo_grupo = item.IdPunto_cargo_grupo,

                            dm_observacion = item.dm_observacion,
                            IdMotivo_Inv = item.IdMotivo_Inv,
                            IdEstadoAproba = item.IdEstadoAproba,
                            Motivo_Aprobacion = item.Motivo_Aprobacion,

                            IdEmpresa_oc = item.IdEmpresa_oc,
                            IdSucursal_oc = item.IdSucursal_oc,
                            IdOrdenCompra = item.IdOrdenCompra,
                            Secuencia_oc = item.Secuencia_oc,

                            //Deben ir null para que al aprobarse se liguen con el nuevo
                            IdEmpresa_inv = null,
                            IdSucursal_inv = null,
                            IdBodega_inv = null,
                            IdMovi_inven_tipo_inv = null,
                            IdNumMovi_inv = null,
                            secuencia_inv = null,

                            IdUnidadMedida = (item.IdUnidadMedida) == null ? "UNID" : item.IdUnidadMedida,
                            IdUnidadMedida_sinConversion = (item.IdUnidadMedida_sinConversion) == null ? "UNID" : item.IdUnidadMedida_sinConversion,
                            dm_cantidad_sinConversion = Math.Abs(item.dm_cantidad_sinConversion) * (info.signo == "-" ? -1 : 1),
                            dm_cantidad = Math.Abs(item.dm_cantidad) * (info.signo == "-" ? -1 : 1),
                            mv_costo_sinConversion = item.mv_costo_sinConversion,
                            mv_costo = item.mv_costo,
                        });                        
                        sec++;
                    }
                    Context.SaveChanges();

                    Context.spINV_aprobacion_ing_egr(info.IdEmpresa, info.IdSucursal, info.IdBodega, info.IdMovi_inven_tipo, info.IdNumMovi);

                    return true;

                }
            }
            catch (Exception e)
            {

                throw;
            }
        }

        public bool anularDB(in_Ing_Egr_Inven_Info info)
        {
            try
            {
                using (Entities_inventario Context = new Entities_inventario())
                {
                    in_Ing_Egr_Inven Entity = Context.in_Ing_Egr_Inven.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdSucursal == info.IdSucursal && q.IdMovi_inven_tipo == info.IdMovi_inven_tipo && q.IdNumMovi == info.IdNumMovi);
                    if (Entity == null) return false;

                    if (Entity.Estado == "I")
                        return true;

                    Entity.Estado = info.Estado="I";

                    Entity.IdusuarioUltAnu = info.IdusuarioUltAnu;
                    Entity.Fecha_UltAnu = DateTime.Now;
                    Context.SaveChanges();
                    Reversar_Aprobacion(info.IdEmpresa, info.IdSucursal, info.IdMovi_inven_tipo, info.IdNumMovi, "");
                }

                return true;

            }
            catch (Exception)
            {

                throw;
            }
        }

        public Boolean Reversar_Aprobacion(int IdEmpresa, int IdSucursal, int IdMovi_inve_tipo, decimal IdNumMovi, string Genera_movi_inven)
        {
            try
            {
                using (Entities_inventario Context = new Entities_inventario())
                {
                    if (Genera_movi_inven == "")
                    {
                        in_movi_inven_tipo enti = Context.in_movi_inven_tipo.Where(q => q.IdEmpresa == IdEmpresa && q.IdMovi_inven_tipo == IdMovi_inve_tipo).FirstOrDefault();
                        if (enti == null) return false;
                        Genera_movi_inven = enti.Genera_Movi_Inven == true ? "S" : "N";
                    }


                    if (Genera_movi_inven == "S")
                    {
                        Context.spSys_inv_Reversar_aprobacion(IdEmpresa, IdSucursal, IdMovi_inve_tipo, IdNumMovi, true);
                    }
                    else
                    {
                        string comando = "update in_Ing_Egr_Inven_det set IdEstadoAproba = 'PEND' where IdEmpresa = " + IdEmpresa + " and IdSucursal = " + IdSucursal + " and IdMovi_inven_tipo = " + IdMovi_inve_tipo + " and IdNumMovi = " + IdNumMovi;
                        Context.Database.ExecuteSqlCommand(comando);
                    }
                }

                return true;
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        public List<in_Ing_Egr_Inven_Info> get_list_por_devolver(int IdEmpresa, string signo, DateTime Fecha_ini, DateTime Fecha_fin)
        {
            try
            {
                List<in_Ing_Egr_Inven_Info> Lista;
                Fecha_ini = Fecha_ini.Date;
                Fecha_fin = Fecha_fin.Date;
                using (Entities_inventario Context = new Entities_inventario())
                {
                    Lista = (from q in Context.vwin_Ing_Egr_Inven_por_devolver
                             where q.IdEmpresa == IdEmpresa
                             && q.signo == signo
                             && Fecha_ini <= q.cm_fecha 
                             && q.cm_fecha <= Fecha_fin
                             select new in_Ing_Egr_Inven_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdMovi_inven_tipo = q.IdMovi_inven_tipo,
                                 IdNumMovi = q.IdNumMovi,
                                 signo = q.signo,
                                 tm_descripcion = q.tm_descripcion,
                                 cm_observacion = q.cm_observacion,
                                 cm_fecha = q.cm_fecha,
                                 Su_Descripcion = q.Su_Descripcion
                             }).ToList();
                }

                Lista.ForEach(q => q.SecuencialID = q.IdEmpresa.ToString("00") + q.IdSucursal.ToString("00") + q.IdMovi_inven_tipo.ToString("00") + q.IdNumMovi.ToString("00000000"));

                return Lista;
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
