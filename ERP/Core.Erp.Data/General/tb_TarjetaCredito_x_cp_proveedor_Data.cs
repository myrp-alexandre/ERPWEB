using Core.Erp.Info.General;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.General
{
    public class tb_TarjetaCredito_x_cp_proveedor_Data
    {
        public List<tb_TarjetaCredito_x_cp_proveedor_Info>GetList(bool MostrarAnulado, int IdEmpresa)
        {
            try
            {
                List<tb_TarjetaCredito_x_cp_proveedor_Info> Lista = new List<tb_TarjetaCredito_x_cp_proveedor_Info>();

                using (Entities_general db = new Entities_general())
                {
                    if (MostrarAnulado == false)
                    {
                        Lista = db.vwtb_TarjetaCredito_x_cp_proveedor.Where(q => q.IdEmpresa == IdEmpresa && q.Estado == true).Select(q => new tb_TarjetaCredito_x_cp_proveedor_Info
                        {
                            IdEmpresa = q.IdEmpresa,
                            IdTransaccion = q.IdTransaccion,
                            IdTarjeta = q.IdTarjeta,                            
                            IdProveedor = q.IdProveedor,
                            Estado = q.Estado,
                            NombreTarjeta = q.NombreTarjeta,
                            pe_nombreCompleto = q.pe_nombreCompleto,
                            pe_cedulaRuc = q.pe_cedulaRuc
                        }).ToList();
                    }
                    else
                    {
                        Lista = db.vwtb_TarjetaCredito_x_cp_proveedor.Where(q => q.IdEmpresa == IdEmpresa).Select(q => new tb_TarjetaCredito_x_cp_proveedor_Info
                        {
                            IdEmpresa = q.IdEmpresa,
                            IdTransaccion = q.IdTransaccion,
                            IdTarjeta = q.IdTarjeta,
                            IdProveedor = q.IdProveedor,
                            Estado = q.Estado,
                            NombreTarjeta = q.NombreTarjeta,
                            pe_nombreCompleto = q.pe_nombreCompleto,
                            pe_cedulaRuc = q.pe_cedulaRuc
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

        public tb_TarjetaCredito_x_cp_proveedor_Info GetInfo(int IdEmpresa, int IdTransaccion, int IdTarjeta, decimal IdProveedor)
        {
            try
            {
                tb_TarjetaCredito_x_cp_proveedor_Info info = new tb_TarjetaCredito_x_cp_proveedor_Info();

                using (Entities_general Context = new Entities_general())
                {
                    tb_TarjetaCredito_x_cp_proveedor Entity = Context.tb_TarjetaCredito_x_cp_proveedor.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdTransaccion == IdTransaccion && q.IdTarjeta == IdTarjeta && q.IdProveedor == IdProveedor);
                    //tb_TarjetaCredito_x_cp_proveedor Entity = Context.tb_TarjetaCredito_x_cp_proveedor.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdTransaccion == IdTransaccion && q.IdTarjeta == IdTarjeta && q.IdProveedor == IdProveedor);
                    if (Entity == null)
                    {
                        return null;
                    }
                    info = new tb_TarjetaCredito_x_cp_proveedor_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdTransaccion = Entity.IdTransaccion,
                        IdTarjeta = Entity.IdTarjeta,                        
                        IdProveedor = Entity.IdProveedor,
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

        public int GetId()
        {

            try
            {
                int ID = 1;
                using (Entities_general db = new Entities_general())
                {
                    var Lista = db.tb_TarjetaCredito_x_cp_proveedor.Select(q => q.IdTransaccion);

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

        public bool GuardarDB(tb_TarjetaCredito_x_cp_proveedor_Info info)
        {
            try
            {
                using (Entities_general db = new Entities_general() )
                {
                    db.tb_TarjetaCredito_x_cp_proveedor.Add(new tb_TarjetaCredito_x_cp_proveedor
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdTransaccion = GetId(),
                        IdTarjeta = info.IdTarjeta,                        
                        IdProveedor =Convert.ToInt32( info.IdProveedor),
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

        public bool ModificarDB(tb_TarjetaCredito_x_cp_proveedor_Info info)
        {
            try
            {
                using (Entities_general db = new Entities_general())
                {
                    tb_TarjetaCredito_x_cp_proveedor Entity = db.tb_TarjetaCredito_x_cp_proveedor.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdTransaccion == info.IdTransaccion).FirstOrDefault();

                    if(Entity == null){
                        return false;
                    }

                    Entity.IdTarjeta = info.IdTarjeta;
                    Entity.IdProveedor = Convert.ToInt32(info.IdProveedor);
                    Entity.IdUsuarioUltMod = info.IdUsuario;
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

        public bool validar_existe_tarjeta_proveedor(int IdEmpresa, int IdTransaccion, int IdTarjeta, decimal IdProveedor)
        {
            try
            {
                using (Entities_general db = new Entities_general())
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
        }

        public bool AnularBD(tb_TarjetaCredito_x_cp_proveedor_Info info)
        {
            try
            {
                using (Entities_general db = new Entities_general())
                {
                    tb_TarjetaCredito_x_cp_proveedor Entity = db.tb_TarjetaCredito_x_cp_proveedor.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdTarjeta == info.IdTarjeta &&  q.IdProveedor == info.IdProveedor).FirstOrDefault();

                    if (Entity == null)
                    {
                        return false;
                    }

                    Entity.Estado = info.Estado;
                    Entity.IdUsuarioUltAnu = info.IdUsuario;
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
