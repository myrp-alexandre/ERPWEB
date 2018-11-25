using Core.Erp.Data.Inventario;
using Core.Erp.Info.Facturacion;
using Core.Erp.Info.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Core.Erp.Data.Facturacion
{
    public class fa_CambioProducto_Data
    {
        public List<fa_CambioProducto_Info> GetList(int IdEmpresa, int IdSucursal, DateTime FechaIni, DateTime FechaFin)
        {
            try
            {
                FechaIni = FechaIni.Date;
                FechaFin = FechaFin.Date;
                int IdSucursalIni = IdSucursal;
                int IdSucursalFin = IdSucursal == 0 ? 99999 : IdSucursal;
                List<fa_CambioProducto_Info> Lista;

                using (Entities_facturacion db = new Entities_facturacion())
                {
                    Lista = db.vwfa_CambioProducto.Where(q => q.IdEmpresa == IdEmpresa
                    && IdSucursalIni <= q.IdSucursal
                    && q.IdSucursal <= IdSucursalFin
                    && FechaIni <= q.Fecha && q.Fecha <= FechaFin).Select(q => new fa_CambioProducto_Info
                    {
                        IdEmpresa = q.IdEmpresa,
                        IdSucursal = q.IdSucursal,
                        IdBodega = q.IdBodega,
                        IdCambio = q.IdCambio,
                        Fecha = q.Fecha,
                        Observacion = q.Observacion,
                        Estado = q.Estado,
                        IdMovi_inven_tipo = q.IdMovi_inven_tipo,
                        IdNumMovi = q.IdNumMovi,

                        bo_Descripcion = q.bo_Descripcion,
                        Su_Descripcion = q.Su_Descripcion,
                    }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public decimal GetId(int IdEmpresa, int IdSucursal, int IdBodega)
        {
            try
            {
                decimal ID = 1;

                using (Entities_facturacion db = new Entities_facturacion())
                {
                    var lst = db.fa_CambioProducto.Where(q => q.IdEmpresa == IdEmpresa && q.IdSucursal == IdSucursal && q.IdBodega == IdBodega).ToList();
                    if (lst.Count > 0)
                        ID = lst.Max(q => q.IdCambio) + 1;
                }

                return ID;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool GuardarDB(fa_CambioProducto_Info info)
        {
            try
            {
                Entities_facturacion db = new Entities_facturacion();
                #region Cambio producto
                db.fa_CambioProducto.Add(new fa_CambioProducto
                {
                    IdEmpresa = info.IdEmpresa,
                    IdSucursal = info.IdSucursal,
                    IdBodega = info.IdBodega,
                    IdCambio = info.IdCambio = GetId(info.IdEmpresa, info.IdSucursal, info.IdBodega),
                    Fecha = info.Fecha.Date,
                    Observacion = info.Observacion,
                    Estado = true,

                    IdUsuario = info.IdUsuario,
                    FechaTransac = DateTime.Now
                });
                int secuencia = 1;
                foreach (var item in info.LstDet)
                {
                    db.fa_CambioProductoDet.Add(new fa_CambioProductoDet
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdSucursal = info.IdSucursal,
                        IdBodega = info.IdBodega,
                        IdCambio = info.IdCambio,
                        Secuencia = secuencia++,

                        IdCbteVta = item.IdCbteVta,
                        SecuenciaFact = item.SecuenciaFact,
                        IdProductoFact = item.IdProductoFact,
                        IdProductoCambio = item.IdProductoCambio,
                        CantidadCambio = item.CantidadCambio,
                        CantidadFact = item.CantidadFact
                    });
                }
                db.SaveChanges();
                #endregion

                Entities_inventario dbi = new Entities_inventario();
                in_Ing_Egr_Inven_Data odata_i = new in_Ing_Egr_Inven_Data();

                var parametro = dbi.in_parametro.Where(q => q.IdEmpresa == info.IdEmpresa).FirstOrDefault();
                if (parametro == null)
                    return true;

                info.IdMovi_inven_tipo = parametro.IdMovi_inven_tipo_Cambio;
                var movi = GenerarMoviInven(info);
                if (movi == null)
                    return true;

                if (odata_i.guardarDB(movi,"-"))
                {
                    info.IdNumMovi = movi.IdNumMovi;
                    db.SaveChanges();


                }

                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool ModificarDB(fa_CambioProducto_Info info)
        {
            try
            {
                using (Entities_facturacion db = new Entities_facturacion())
                {
                    var Entity = db.fa_CambioProducto.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdSucursal == info.IdSucursal && q.IdBodega == info.IdBodega && q.IdCambio == info.IdCambio).FirstOrDefault();
                    if (Entity == null) return false;
                    Entity.Fecha = info.Fecha;
                    Entity.Observacion = info.Observacion;

                    Entity.IdUsuarioUltMod = info.IdUsuario;
                    Entity.FechaUltMod = DateTime.Now;

                    var lst = db.fa_CambioProductoDet.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdSucursal == info.IdSucursal && q.IdBodega == info.IdBodega && q.IdCambio == info.IdCambio).ToList();
                    db.fa_CambioProductoDet.RemoveRange(lst);
                    int secuencia = 1;
                    foreach (var item in info.LstDet)
                    {
                        db.fa_CambioProductoDet.Add(new fa_CambioProductoDet
                        {
                            IdEmpresa = info.IdEmpresa,
                            IdSucursal = info.IdSucursal,
                            IdBodega = info.IdBodega,
                            IdCambio = info.IdCambio,
                            Secuencia = secuencia++,

                            IdCbteVta = item.IdCbteVta,
                            SecuenciaFact = item.SecuenciaFact,
                            IdProductoFact = item.IdProductoFact,
                            IdProductoCambio = item.IdProductoCambio,
                            CantidadCambio = item.CantidadCambio,
                            CantidadFact = item.CantidadFact
                        });
                    }

                    db.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool AnularDB(fa_CambioProducto_Info info)
        {
            try
            {
                using (Entities_facturacion db = new Entities_facturacion())
                {
                    var Entity = db.fa_CambioProducto.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdSucursal == info.IdSucursal && q.IdBodega == info.IdBodega && q.IdCambio == info.IdCambio).FirstOrDefault();
                    if (Entity == null) return false;
                    Entity.Estado = false;

                    Entity.IdUsuarioUltAnu = info.IdUsuario;
                    Entity.FechaUltAnu = DateTime.Now;
                    db.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public fa_CambioProducto_Info GetInfo(int IdEmpresa, int IdSucursal, int IdBodega, decimal IdCambio)
        {
            try
            {
                fa_CambioProducto_Info info;
                using (Entities_facturacion db = new Entities_facturacion())
                {
                    var Entity = db.fa_CambioProducto.Where(q => q.IdEmpresa == IdEmpresa && q.IdSucursal == IdSucursal && q.IdBodega == IdBodega && q.IdCambio == IdCambio).FirstOrDefault();
                    if (Entity == null) return null;
                    info = new fa_CambioProducto_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdSucursal = Entity.IdSucursal,
                        IdBodega = Entity.IdBodega,
                        IdCambio = Entity.IdCambio,
                        Fecha = Entity.Fecha,
                        Observacion = Entity.Observacion,
                        Estado = Entity.Estado,
                        IdMovi_inven_tipo = Entity.IdMovi_inven_tipo,
                        IdNumMovi = Entity.IdNumMovi,
                    };
                }
                return info;
            }
            catch (Exception)
            {
                throw;
            }
        }

        private in_Ing_Egr_Inven_Info GenerarMoviInven(fa_CambioProducto_Info info)
        {
            try
            {
                using (Entities_inventario db = new Entities_inventario())
                {
                    var motivo = db.in_Motivo_Inven.Where(q => q.IdEmpresa == info.IdEmpresa && q.Genera_Movi_Inven == "S" && q.Tipo_Ing_Egr == "EGR").FirstOrDefault();
                    if (motivo == null)
                        return null;

                    in_Ing_Egr_Inven_Info movi = new in_Ing_Egr_Inven_Info
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdSucursal = info.IdSucursal,
                        IdBodega = info.IdBodega,
                        IdMovi_inven_tipo = (int)info.IdMovi_inven_tipo,
                        IdNumMovi = info.IdNumMovi == null ? 0 : Convert.ToDecimal(info.IdNumMovi),
                        cm_fecha = info.Fecha.Date,
                        cm_observacion = "CAMB#" + info.IdCambio + " " + info.Observacion,
                        Estado = "A",
                        CodMoviInven = "CAMB#" + info.IdCambio,
                        signo = "-",
                        IdUsuario = info.IdUsuario,
                        IdUsuarioUltModi = info.IdUsuario,
                        IdMotivo_Inv = motivo.IdMotivo_Inv
                    };
                    int secuencia = 1;
                    foreach (var item in info.LstDet)
                    {
                        var producto = db.in_Producto.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdProducto == item.IdProductoCambio).FirstOrDefault();
                        if (producto == null)
                            return null;

                        movi.lst_in_Ing_Egr_Inven_det.Add(new in_Ing_Egr_Inven_det_Info
                        {
                            IdEmpresa = movi.IdEmpresa,
                            IdSucursal = movi.IdSucursal,
                            IdBodega = (int)movi.IdBodega,
                            IdMovi_inven_tipo = movi.IdMovi_inven_tipo,
                            IdNumMovi = 0,
                            Secuencia = secuencia++,
                            IdProducto = item.IdProductoCambio,
                            dm_cantidad = item.CantidadCambio * -1,
                            dm_cantidad_sinConversion = item.CantidadCambio * -1,
                            mv_costo = 0,
                            mv_costo_sinConversion = 0,
                            IdUnidadMedida = producto.IdUnidadMedida_Consumo,
                            IdUnidadMedida_sinConversion = producto.IdUnidadMedida_Consumo,
                        });
                    }
                    return movi;
                }

                
            }
            catch (Exception)
            {

                throw;
            }
        }

        private void GenerarDevoluciones(List<fa_CambioProductoDet_Info> ListaCambios)
        {
            try
            {
                
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
