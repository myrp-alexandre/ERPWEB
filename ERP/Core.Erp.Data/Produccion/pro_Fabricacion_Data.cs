using Core.Erp.Info.Produccion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Produccion
{
    public class pro_Fabricacion_Data
    {
       public List<pro_Fabricacion_Info> GetList(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<pro_Fabricacion_Info> Lista;
                using (Entities_produccion Context = new Entities_produccion())
                {
                    if(mostrar_anulados==false)
                    Lista = Context.pro_Fabricacion.Where(q => q.IdEmpresa == IdEmpresa).Select(q => new pro_Fabricacion_Info
                    {
                        IdEmpresa = q.IdEmpresa,
                        egr_IdSucursal = q.egr_IdSucursal,
                        ing_IdSucursal = q.ing_IdSucursal,
                        Estado = q.Estado,
                        egr_IdBodega = q.egr_IdBodega,
                        egr_IdMovi_inven_tipo = q.egr_IdMovi_inven_tipo,
                        egr_IdNumMovi = q.egr_IdNumMovi,
                        Fecha = q.Fecha,
                        IdFabricacion = q.IdFabricacion,
                        ing_IdBodega = q.ing_IdBodega,
                        ing_IdMovi_inven_tipo = q.ing_IdMovi_inven_tipo,
                        Observacion = q.Observacion,
                        ing_IdNumMovi = q.ing_IdNumMovi



                    }).ToList();

                    else
                        Lista = Context.pro_Fabricacion.Where(q => q.IdEmpresa == IdEmpresa && q.Estado == true).Select(q => new pro_Fabricacion_Info
                        {
                            IdEmpresa = q.IdEmpresa,
                            egr_IdSucursal = q.egr_IdSucursal,
                            ing_IdSucursal = q.ing_IdSucursal,
                            Estado = q.Estado,
                            egr_IdBodega = q.egr_IdBodega,
                            egr_IdMovi_inven_tipo = q.egr_IdMovi_inven_tipo,
                            egr_IdNumMovi = q.egr_IdNumMovi,
                            Fecha = q.Fecha,
                            IdFabricacion = q.IdFabricacion,
                            ing_IdBodega = q.ing_IdBodega,
                            ing_IdMovi_inven_tipo = q.ing_IdMovi_inven_tipo,
                            Observacion = q.Observacion,
                            ing_IdNumMovi = q.ing_IdNumMovi
                        }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public pro_Fabricacion_Info GetInfo(int IdEmpresa,  decimal IdFabricacion)
        {
            try
            {
                pro_Fabricacion_Info info = new pro_Fabricacion_Info();
                using (Entities_produccion Context = new Entities_produccion())
                {
                    pro_Fabricacion Entity = Context.pro_Fabricacion.Where(q => q.IdEmpresa == IdEmpresa && q.IdFabricacion == IdFabricacion).FirstOrDefault();
                    if (Entity == null) return null;

                    info = new pro_Fabricacion_Info
                    {

                        IdEmpresa = Entity.IdEmpresa,
                        egr_IdSucursal = Entity.egr_IdSucursal,
                        ing_IdSucursal = Entity.ing_IdSucursal,
                        Estado = Entity.Estado,
                        egr_IdBodega = Entity.egr_IdBodega,
                        egr_IdMovi_inven_tipo = Entity.egr_IdMovi_inven_tipo,
                        egr_IdNumMovi = Entity.egr_IdNumMovi,
                        Fecha = Entity.Fecha,
                        IdFabricacion = Entity.IdFabricacion,
                        ing_IdBodega = Entity.ing_IdBodega,
                        ing_IdMovi_inven_tipo = Entity.ing_IdMovi_inven_tipo,
                        Observacion = Entity.Observacion,
                        ing_IdNumMovi = Entity.ing_IdNumMovi
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        private decimal GetId(int IdEmpresa)
        {
            try
            {
                decimal ID = 1;
                using (Entities_produccion Context = new Entities_produccion())
                {
                    var lst = Context.pro_Fabricacion.Where(q => q.IdEmpresa == IdEmpresa).Select(q => q.IdFabricacion);
                    if (lst.Count() > 0)
                        ID = lst.Max() + 1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool GuardarDB(pro_Fabricacion_Info info)
        {
            try
            {
                using (Entities_produccion Context = new Entities_produccion())
                {
                    Context.pro_Fabricacion.Add( new pro_Fabricacion
                    {

                        IdEmpresa = info.IdEmpresa,
                        IdFabricacion = info.IdFabricacion=GetId(info.IdEmpresa),
                        egr_IdSucursal = info.egr_IdSucursal,
                        ing_IdSucursal = info.ing_IdSucursal,
                        Estado = true,
                        egr_IdBodega = info.egr_IdBodega,
                        egr_IdMovi_inven_tipo = info.egr_IdMovi_inven_tipo,
                        egr_IdNumMovi = info.egr_IdNumMovi,
                        Fecha = info.Fecha,
                        ing_IdBodega = info.ing_IdBodega,
                        ing_IdMovi_inven_tipo = info.ing_IdMovi_inven_tipo,
                        Observacion = info.Observacion,
                        ing_IdNumMovi = info.ing_IdNumMovi,

                        IdUsuarioCreacion = info.IdUsuarioCreacion,
                        FechaCreacion = DateTime.Now
                    });

                    if(info.LstDet.Count()>0)
                    {
                        foreach (var item in info.LstDet)
                        {
                            Context.pro_FabricacionDet.Add(new pro_FabricacionDet
                            {
                                IdEmpresa = info.IdEmpresa,
                                IdFabricacion = info.IdFabricacion,
                                IdProducto = item.IdProducto,
                                Cantidad = item.Cantidad,
                                Costo = item.Costo,
                                RealizaMovimiento = item.RealizaMovimiento,
                                Secuencia = item.Secuencia,
                                Signo = item.Signo,
                                IdUnidadMedida = item.IdUnidadMedida
                            });
                        }

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

        public bool ModificarDB(pro_Fabricacion_Info info)
        {
            try
            {
                using (Entities_produccion Context = new Entities_produccion())
                {
                    pro_Fabricacion Entity = Context.pro_Fabricacion.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdFabricacion == info.IdFabricacion).FirstOrDefault();
                    if (Entity == null) return false;
                    Entity.egr_IdSucursal = info.egr_IdSucursal;
                    Entity.ing_IdSucursal = info.ing_IdSucursal;
                    Entity.egr_IdBodega = info.egr_IdBodega;
                    Entity.egr_IdMovi_inven_tipo = info.egr_IdMovi_inven_tipo;
                    Entity.egr_IdNumMovi = info.egr_IdNumMovi;
                    Entity.Fecha = info.Fecha;
                    Entity.ing_IdBodega = info.ing_IdBodega;
                    Entity.ing_IdMovi_inven_tipo = info.ing_IdMovi_inven_tipo;
                    Entity.Observacion = info.Observacion;
                    Entity.ing_IdNumMovi = info.ing_IdNumMovi;

                    Entity.IdUsuarioModificacion = info.IdUsuarioModificacion;
                    Entity.FechaModificacion = DateTime.Now;


                    var detalle = Context.pro_FabricacionDet.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdFabricacion == info.IdFabricacion);
                    Context.pro_FabricacionDet.RemoveRange(detalle);
                    if (info.LstDet.Count() > 0)
                    {
                        foreach (var item in info.LstDet)
                        {
                            Context.pro_FabricacionDet.Add(new pro_FabricacionDet
                            {
                                IdEmpresa = info.IdEmpresa,
                                IdFabricacion = info.IdFabricacion,
                                IdProducto = item.IdProducto,
                                Cantidad = item.Cantidad,
                                Costo = item.Costo,
                                RealizaMovimiento = item.RealizaMovimiento,
                                Secuencia = item.Secuencia,
                                Signo = item.Signo,
                                IdUnidadMedida = item.IdUnidadMedida
                                
                            });
                        }

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

        public bool AnularDB(pro_Fabricacion_Info info)
        {
            try
            {
                using (Entities_produccion Context = new Entities_produccion())
                {
                    pro_Fabricacion Entity = Context.pro_Fabricacion.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdFabricacion == info.IdFabricacion).FirstOrDefault();
                    if (Entity == null) return false;
                    Entity.Estado = false;

                    Entity.IdUsuarioAnulacion = info.IdUsuarioAnulacion;
                    Entity.FechaAnulacion = DateTime.Now;
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
