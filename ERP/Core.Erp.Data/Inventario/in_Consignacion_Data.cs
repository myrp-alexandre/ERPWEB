using Core.Erp.Info.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Inventario
{
    public class in_Consignacion_Data
    {
        public List<in_Consignacion_Info> GetList(int IdEmpresa, string signo, bool mostrar_anulados, DateTime fecha_ini, DateTime fecha_fin)
        {
            try
            {
                List<in_Consignacion_Info> Lista = new List<in_Consignacion_Info>();

                using (Entities_inventario db = new Entities_inventario())
                {
                    if (mostrar_anulados == false)
                    {
                        Lista = db.vwin_consignacion.Where(q => q.IdEmpresa == IdEmpresa && q.Estado == true).Select(q => new in_Consignacion_Info
                        {
                            IdEmpresa = q.IdEmpresa,
                            IdConsignacion = q.IdConsignacion,
                            IdSucursal = q.IdSucursal,
                            FechaConsignacion = q.FechaConsignacion,
                            IdProveedor = q.IdProveedor,
                            pe_nombreCompleto = q.pe_nombreCompleto,
                            pe_cedulaRuc = q.pe_cedulaRuc,
                            Observacion = q.Observacion,
                            Estado = q.Estado                            
                        }).ToList();
                    }
                    else
                    {
                        Lista = db.vwin_consignacion.Where(q => q.IdEmpresa == IdEmpresa).Select(q => new in_Consignacion_Info
                        {
                            IdEmpresa = q.IdEmpresa,
                            IdConsignacion = q.IdConsignacion,
                            IdSucursal = q.IdSucursal,
                            FechaConsignacion = q.FechaConsignacion,
                            IdProveedor = q.IdProveedor,
                            pe_nombreCompleto = q.pe_nombreCompleto,
                            pe_cedulaRuc = q.pe_cedulaRuc,
                            Observacion = q.Observacion,
                            Estado = q.Estado
                        }).ToList();
                    }
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public in_Consignacion_Info GetInfo(int IdEmpresa, int IdConsignacion)
        {
            try
            {
                in_Consignacion_Info info = new in_Consignacion_Info();

                using (Entities_inventario Context = new Entities_inventario())
                {
                    In_consignacion Entity = Context.In_consignacion.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdConsignacion == IdConsignacion);    
                    
                    if (Entity == null)
                    {
                        return null;
                    }
                    info = new in_Consignacion_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdConsignacion = Entity.IdConsignacion,
                        IdSucursal = Entity.IdSucursal,
                        FechaConsignacion = Entity.FechaConsignacion,
                        IdProveedor = Entity.IdProveedor,
                        Observacion = Entity.Observacion,
                        Estado = Entity.Estado
                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public decimal GetId()
        {

            try
            {
                decimal ID = 1;
                using (Entities_inventario db = new Entities_inventario())
                {
                    var Lista = db.In_consignacion.Select(q => q.IdConsignacion);

                    if (Lista.Count() > 0)
                        ID = Lista.Max() + 1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool GuardarBD(in_Consignacion_Info info)
        {
            try
            {
                using (Entities_inventario db = new Entities_inventario())
                {
                    db.In_consignacion.Add(new In_consignacion
                    {
                        IdConsignacion = GetId(),
                        IdSucursal = info.IdSucursal,
                        FechaConsignacion = info.FechaConsignacion,
                        IdProveedor = info.IdProveedor,
                        Observacion = info.Observacion,
                        Estado = info.Estado = true,
                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = DateTime.Now
                    });

                    db.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool ModificarDB(in_Consignacion_Info info)
        {
            try
            {
                using (Entities_inventario db = new Entities_inventario())
                {
                    In_consignacion Entity = db.In_consignacion.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdConsignacion == info.IdConsignacion).FirstOrDefault();

                    if (Entity == null)
                    {
                        return false;
                    }

                    Entity.IdConsignacion = info.IdConsignacion;
                    Entity.IdProveedor = Convert.ToInt32(info.IdProveedor);
                    Entity.IdSucursal = info.IdSucursal;
                    Entity.FechaConsignacion = info.FechaConsignacion;
                    Entity.Observacion = info.Observacion;
                    Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    Entity.Fecha_UltMod = DateTime.Now;

                    db.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        /*public bool validar_existe_tarjeta_proveedor(int IdEmpresa, int IdTransaccion, int IdTarjeta, decimal IdProveedor)
        {
            try
            {
                using (Entities_inventario db = new Entities_inventario())
                {
                    if (IdTransaccion == 0)
                    {
                        tb_TarjetaCredito_x_cp_proveedor Entity = db.tb_TarjetaCredito_x_cp_proveedor.Where(q => q.IdEmpresa == IdEmpresa && q.IdTarjeta == IdTarjeta && q.IdProveedor == IdProveedor).FirstOrDefault();

                        if (Entity == null)
                        {
                            return false;
                        }
                        return true;
                    }
                    else
                    {
                        tb_TarjetaCredito_x_cp_proveedor Entity = db.tb_TarjetaCredito_x_cp_proveedor.Where(q => q.IdEmpresa == IdEmpresa && q.IdTarjeta == IdTarjeta && q.IdProveedor == IdProveedor && q.IdTransaccion != IdTransaccion).FirstOrDefault();

                        if (Entity == null)
                        {
                            return false;
                        }
                        return true;
                    }
                }
            }
            catch (Exception)
            {
                throw;
            }
        }*/

        public bool AnularBD(in_Consignacion_Info info)
        {
            try
            {
                using (Entities_inventario db = new Entities_inventario())
                {
                    In_consignacion Entity = db.In_consignacion.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdConsignacion == info.IdConsignacion).FirstOrDefault();

                    if (Entity == null)
                    {
                        return false;
                    }

                    Entity.Estado = info.Estado;
                    Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                    Entity.Fecha_UltAnu = DateTime.Now;

                    db.SaveChanges();
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
