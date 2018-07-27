using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Core.Erp.Data.Facturacion
{
    public class fa_notaCreDeb_Data
    {
        public List<fa_notaCreDeb_consulta_Info> get_list(int IdEmpresa, DateTime Fecha_ini, DateTime Fecha_fin, string CreDeb)
        {
            try
            {
                List<fa_notaCreDeb_consulta_Info> Lista;
                Fecha_ini = Fecha_ini.Date;
                Fecha_fin = Fecha_fin.Date;
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    Lista = (from q in Context.vwfa_notaCreDeb
                             where q.IdEmpresa == IdEmpresa
                             && Fecha_ini <= q.no_fecha
                             && q.no_fecha <= Fecha_fin
                             && q.CreDeb == CreDeb
                             select new fa_notaCreDeb_consulta_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdBodega = q.IdBodega,
                                 IdNota = q.IdNota,
                                 CreDeb = q.CreDeb,
                                 NumNota_Impresa = q.NumNota_Impresa,
                                 no_fecha = q.no_fecha,
                                 Nombres = q.Nombres,
                                 sc_subtotal = q.sc_subtotal,
                                 sc_iva = q.sc_iva,
                                 sc_total = q.sc_total,
                                 Estado = q.Estado,
                             }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public fa_notaCreDeb_Info get_info(int IdEmpresa, int IdSucursal, int IdBodega, decimal IdNota)
        {
            try
            {
                fa_notaCreDeb_Info info;

                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    var Entity = Context.fa_notaCreDeb.Where(q => q.IdEmpresa == IdEmpresa && q.IdSucursal == IdSucursal && q.IdBodega == IdBodega && q.IdNota == IdNota).FirstOrDefault();
                    if (Entity == null) return null;
                    info = new fa_notaCreDeb_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdSucursal = Entity.IdSucursal,
                        IdBodega = Entity.IdBodega,
                        IdNota = Entity.IdNota,
                        IdPuntoVta = Entity.IdPuntoVta,
                        CodNota = Entity.CodNota,
                        CreDeb = Entity.CreDeb,
                        CodDocumentoTipo = Entity.CodDocumentoTipo,
                        Serie1 = Entity.Serie1,
                        Serie2 = Entity.Serie2,
                        NumNota_Impresa = Entity.NumNota_Impresa,
                        NumAutorizacion = Entity.NumAutorizacion,
                        Fecha_Autorizacion = Entity.Fecha_Autorizacion,
                        IdCliente = Entity.IdCliente,
                        IdContacto = Entity.IdContacto,
                        no_fecha = Entity.no_fecha,
                        no_fecha_venc = Entity.no_fecha_venc,
                        IdTipoNota = Entity.IdTipoNota,
                        sc_observacion = Entity.sc_observacion,
                        Estado = Entity.Estado,
                        NaturalezaNota = Entity.NaturalezaNota,
                        IdCtaCble_TipoNota = Entity.IdCtaCble_TipoNota
                    };
                }

                return info;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public decimal get_id(int IdEmpresa, int IdSucursal, int IdBodega)
        {
            try
            {
                decimal ID = 1;

                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    var lst = from q in Context.fa_notaCreDeb
                              where q.IdEmpresa == IdEmpresa
                              && q.IdSucursal == IdSucursal
                              && q.IdBodega == IdBodega
                              select q;

                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdNota) + 1;
                }

                return ID;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool guardarDB(fa_notaCreDeb_Info info)
        {            
            try
            {
                #region Variables
                int Secuencia = 1;
                #endregion

                using (Entities_facturacion db_f = new Entities_facturacion())
                {
                    db_f.fa_notaCreDeb.Add(new fa_notaCreDeb
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdSucursal = info.IdSucursal,
                        IdBodega = info.IdBodega,
                        IdNota = info.IdNota = get_id(info.IdEmpresa,info.IdSucursal,info.IdBodega),
                        IdPuntoVta = info.IdPuntoVta,
                        CodNota = info.CodNota,
                        CreDeb = info.CreDeb,
                        CodDocumentoTipo = info.CodDocumentoTipo,
                        Serie1 = info.Serie1,
                        Serie2 = info.Serie2,
                        NumNota_Impresa = info.NumNota_Impresa,
                        NumAutorizacion = info.NumAutorizacion,
                        Fecha_Autorizacion = info.Fecha_Autorizacion,
                        IdCliente = info.IdCliente,
                        IdContacto = info.IdContacto,
                        no_fecha = info.no_fecha,
                        no_fecha_venc = info.no_fecha_venc,
                        IdTipoNota = info.IdTipoNota,
                        sc_observacion = info.sc_observacion,
                        Estado = info.Estado = "A",
                        NaturalezaNota = info.NaturalezaNota,
                        IdCtaCble_TipoNota = info.IdCtaCble_TipoNota,

                        IdUsuario = info.IdUsuario                        
                    });

                    foreach (var item in info.lst_det)
                    {
                        db_f.fa_notaCreDeb_det.Add(new fa_notaCreDeb_det
                        {
                            IdEmpresa = info.IdEmpresa,
                            IdSucursal = info.IdSucursal,
                            IdBodega = info.IdBodega,
                            IdNota = info.IdNota,
                            Secuencia = Secuencia++,
                            IdProducto = item.IdProducto,
                            sc_cantidad = item.sc_cantidad,
                            sc_Precio = item.sc_Precio,
                            sc_descUni = item.sc_descUni,
                            sc_PordescUni = item.sc_PordescUni,
                            sc_precioFinal = item.sc_precioFinal,
                            vt_por_iva = item.vt_por_iva,
                            sc_iva = item.sc_iva,
                            IdCod_Impuesto_Iva = item.IdCod_Impuesto_Iva,
                            sc_estado = "A",
                            sc_subtotal = item.sc_subtotal,
                            sc_total = item.sc_total
                        });
                    }
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
